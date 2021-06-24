//
//  CustomTableViewCell.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 22.06.21.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
    
    
    var customImage: UIImage? {
        didSet {
            memeImage.image = customImage
        }
    }
    
    var customLabel: String? {
        didSet {
            memeLabel.text = customLabel
        }
    }
}
