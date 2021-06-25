//
//  EditorViewController.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 22.06.21.
//

import UIKit

final class EditorViewController: UIViewController {
    let meme: Meme
    var memeImage = UIImage()
    
    init?(coder: NSCoder, meme: Meme) {
        self.meme = meme
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var generateMemeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text5: UITextField!
    
    

    @IBSegueAction func makeFinalMeme(_ coder: NSCoder) -> FinalMemeViewController? {

        var boxes = [Box]()
        
        switch meme.box_count {
        case 2:
            boxes.append(Box(text: text1.text ?? "Error"))
            boxes.append(Box(text: text2.text ?? "Error"))
        case 3:
            boxes.append(Box(text: text1.text ?? "Error"))
            boxes.append(Box(text: text2.text ?? "Error"))
            boxes.append(Box(text: text3.text ?? "Error"))
        case 4:
            boxes.append(Box(text: text1.text ?? "Error"))
            boxes.append(Box(text: text2.text ?? "Error"))
            boxes.append(Box(text: text3.text ?? "Error"))
            boxes.append(Box(text: text4.text ?? "Error"))
        case 5:
            boxes.append(Box(text: text1.text ?? "Error"))
            boxes.append(Box(text: text2.text ?? "Error"))
            boxes.append(Box(text: text3.text ?? "Error"))
            boxes.append(Box(text: text4.text ?? "Error"))
            boxes.append(Box(text: text5.text ?? "Error"))
        default:
            boxes.append(Box(text: text1.text ?? "Error"))
            boxes.append(Box(text: text2.text ?? "Error"))
            boxes.append(Box(text: text3.text ?? "Error"))
            boxes.append(Box(text: text4.text ?? "Error"))
            boxes.append(Box(text: text5.text ?? "Error"))
        }
        
        let finalImageData = CaptionImageData(id: meme.id ?? "", username: "blablabla", password: "blablabla", boxes: boxes)
        
        return FinalMemeViewController(coder: coder, data: finalImageData)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.hidesWhenStopped = true
        
        switch meme.box_count {
        case 2:
            text3.isHidden = true
            text4.isHidden = true
            text5.isHidden = true
        case 3:
            text4.isHidden = true
            text5.isHidden = true
        case 4:
            text5.isHidden = true
        default:
            text1.isHidden = false
            text2.isHidden = false
            text3.isHidden = false
            text4.isHidden = false
            text5.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator.startAnimating()
        NetworkManager().fetchMemeImage(url: meme.url ?? "", completionHandler: { [weak self] (newImage) in
            self?.memeImage = newImage.image ?? UIImage()
            DispatchQueue.main.sync {
                self?.imageView.image = self?.memeImage
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
