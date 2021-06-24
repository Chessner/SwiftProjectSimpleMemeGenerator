//
//  File.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 24.06.21.
//

import UIKit

class NetworkManager {
    let getMemeListURL = URL(string: "https://api.imgflip.com/get_memes")
    
    func fetchMemeList(completionHandler: @escaping (MemesData) -> Void) {
        let session = URLSession.shared
//        let url = URL(string:"https://api.imgflip.com/get_memes")
        if let url = getMemeListURL {
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                print(response?.description ?? "")
                if let data = data {
//                    print(String(decoding: data, as: UTF8.self))
                    let memesData = try? JSONDecoder().decode(MemesData.self, from: data)
                    completionHandler(memesData ?? MemesData())
                }
            })
            task.resume()
        }
    }
    
    func fetchMemeImage(url: String, completionHandler: @escaping (UIImage) -> Void) {
        let imageUrl = URL(string: url)
        let session = URLSession.shared
//        if let url = imageUrl{
//            let task = session.dataTask(with: url, completionHandler: { data, response, error in
//                print(response?.description ?? "")
//                if let data = data {
//                    DispatchQueue.main.async { /// execute on main thread
//                    self.imageView.image = UIImage(data: data)
//                }
//
//            })
//                task.resume
       // }
        
    }
    
}
