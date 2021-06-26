//
//  CaptionImageData.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 25.06.21.
//

import Foundation

struct CaptionImageRequestData : Codable{
    var template_id: String?
    var username: String?
    var password: String?
    var boxes: [String]
    
    init(id: String, username: String, password: String, boxes: [String]) {
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

struct CaptionImageResponseData : Codable{
    var success: Bool?
    var data: urlData?
}

struct urlData : Codable{
    var url: String?
    var page_url: String?
}
