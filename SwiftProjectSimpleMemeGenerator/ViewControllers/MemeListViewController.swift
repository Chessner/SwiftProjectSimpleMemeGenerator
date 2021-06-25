//
//  ViewController.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 22.06.21.
//

import UIKit
import Foundation

class MemeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    private var data = MemesData()
    private var images: [UIImage]?
    private var editMeme = Meme()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let cellIdentifier = "CustomTableViewCell"
    
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        images = [UIImage]()
        
        activityIndicator.startAnimating()
        NetworkManager().fetchMemeList(completionHandler: { [weak self] (data) in
            self?.data = data
            
            //Create array with 100 images
            var i = 0
            while i < data.data?.memes?.count ?? 0{
                self?.images?.append(UIImage())
                i += 1
            }
            
            
            //Download all images
            var j = 0
            while j < data.data?.memes?.count ?? 0{
                NetworkManager().fetchMemeImage(url: data.data?.memes?[j].url ?? "", completionHandler: { [weak self] (newImage) in
                    
                    //Look for correct position in array for image
                    var x = 0
                    while newImage.url != data.data?.memes?[x].url {
                        x += 1
                    }
                    self?.images?[x] = newImage.image ?? UIImage()
                    
                    DispatchQueue.main.sync {
                        var row = x
                        if row != 0{
                            row -= 1
                        }
                        self?.tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: UITableView.RowAnimation.right)
                    }
                })
                j += 1
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        })
        
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.hidesWhenStopped = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: .main), forCellReuseIdentifier: "CustomTableViewCell")
    }

    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if data.data?.memes?[indexPath.row].box_count ?? 0 >= 2 && ((data.data?.memes?[indexPath.row].box_count ?? 0) <= 5)  {
            editMeme = data.data?.memes?[indexPath.row] ?? Meme()
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            performSegue(withIdentifier: "showEditor", sender: self)
        }
    }
    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    

    
    // MARK: - IBSegueAction
    @IBSegueAction func makeEditorViewController(_ coder: NSCoder) -> EditorViewController? {
        return EditorViewController(coder: coder, meme: editMeme)
    }
    




    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.data?.memes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        tableViewCell.customLabel = data.data?.memes?[indexPath.row].name
        let row = indexPath.row
        if images?.count ?? 0 > row{
            tableViewCell.customImage = images?[row]
        } else {
            tableViewCell.customImage = nil
        }
        
        return tableViewCell
    }

    
}

