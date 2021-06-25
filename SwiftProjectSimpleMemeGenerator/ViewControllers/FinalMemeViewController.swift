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
    private let captionImageData: CaptionImageData?
    private var image = UIImage()
    
    init?(coder: NSCoder, data: CaptionImageData) {
        captionImageData = data
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NetworkManager().fetchCaptionImage(captionImageData: captionImageData!, completionHandler: { [weak self] (newImage) in
            self?.image = newImage
            DispatchQueue.main.sync {
                self?.imageView.image = self?.image
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
