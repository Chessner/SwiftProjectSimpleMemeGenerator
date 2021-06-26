//
//  FinalMemeViewController.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 22.06.21.
//

import UIKit

final class FinalMemeViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveImageButton: UIButton!
    private let captionImageData: CaptionImageRequestData?
    private var image = UIImage()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    init?(coder: NSCoder, data: CaptionImageRequestData) {
        captionImageData = data
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator.startAnimating()
        
        NetworkManager().fetchCaptionImage(captionImageData: captionImageData!, completionHandler: { [weak self] (newImage) in
            self?.image = newImage
            DispatchQueue.main.sync {
                self?.imageView.image = self?.image
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
    }
    
    //Save image to library.
    @IBAction func saveImageToLibrary(_ sender: Any) {
        if image != UIImage(){
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    

}
