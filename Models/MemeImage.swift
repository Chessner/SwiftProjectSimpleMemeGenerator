//
//  MemeImage.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 25.06.21.
//

import Foundation
import UIKit

struct MemeImage{
    var image: UIImage?
    var url: String?
    
    init(image: UIImage, url: String) {
        self.image = image
        self.url = url
    }
}
