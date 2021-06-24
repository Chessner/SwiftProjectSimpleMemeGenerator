//
//  ViewController.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 22.06.21.
//

import UIKit

class MemeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    private var data = MemesData()
    private var images: [UIImage]?
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var reloadListButton: UIButton!
    
    private let cellIdentifier = "CustomTableViewCell"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator.startAnimating()
        NetworkManager().fetchMemeList(completionHandler: { [weak self] (data) in
            self?.data = data
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
        tableViewCell.customImage = nil
//        let tableViewCell = tableView.dequeueReusableCell(withIdentifier:"\(UITableViewCell.self)" ,for: indexPath)
//        tableViewCell.textLabel?.text = "Hello"
        return tableViewCell
    }


}

