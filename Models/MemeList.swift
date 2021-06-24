//
//  MemeList.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 24.06.21.
//

import Foundation
struct MemesData: Codable{
    var success: Bool?
    var data: MemeArray?
    
    init() {
        data = MemeArray()
        success = false
    }
}

struct MemeArray : Codable{
    var memes: [Meme]?
    
    init() {
        memes = []
    }
}

struct Meme: Codable{
    var id: String?
    var name: String?
    var url: String?
    var width: Int?
    var height: Int?
    var box_count: Int?
}
