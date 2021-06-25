//
//  CaptionImageData.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 25.06.21.
//

import Foundation

struct CaptionImageData : Codable{
    var template_id: String?
    var username: String?
    var password: String?
    var boxes: [Box]?
    
    init(id: String, username: String, password: String, boxes: [Box]) {
        template_id = id
        self.username = username
        self.password = password
        self.boxes = boxes
    }
}

struct Box: Codable{
    var text: String?
    
    init(text: String) {
        self.text = text
    }
}
