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
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var reloadListButton: UIButton!
    
    private let cellIdentifier = "CustomTableViewCell"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        images = [UIImage]()
        
        activityIndicator.startAnimating()
        NetworkManager().fetchMemeList(completionHandler: { [weak self] (data) in
            self?.data = data
            
            var i = 0
            while i < data.data?.memes?.count ?? 0{
                NetworkManager().fetchMemeImage(url: data.data?.memes?[i].url ?? "", completionHandler: { [weak self] (newImage) in
                    self?.images?.append(newImage)
                })
                i += 1
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.hidesWhenStopped = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: .main), forCellReuseIdentifier: "CustomTableViewCell")
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
        if images?.count ?? 0 > indexPath.row{
            tableViewCell.customImage = images?[indexPath.row]
        }

        return tableViewCell
    }
    
    
}

