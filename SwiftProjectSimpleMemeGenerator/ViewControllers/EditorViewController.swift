//
//  EditorViewController.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 22.06.21.
//

import UIKit

final class EditorViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var generateMemeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
