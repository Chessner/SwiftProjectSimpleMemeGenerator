//
//  File.swift
//  SwiftProjectSimpleMemeGenerator
//
//  Created by Florian Schachner on 24.06.21.
//

import UIKit

class NetworkManager {
    let getMemeListURL = URL(string: "https://api.imgflip.com/get_memes")
    let getCaptionImageURL = URL(string: "https://api.imgflip.com/caption_image")!
    
    func fetchMemeList(completionHandler: @escaping (MemesData) -> Void) {
        let session = URLSession.shared
        //        let url = URL(string:"https://api.imgflip.com/get_memes")
        if let url = getMemeListURL {
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                //print(response?.description ?? "")
                if let data = data {
                    //                    print(String(decoding: data, as: UTF8.self))
                    let memesData = try? JSONDecoder().decode(MemesData.self, from: data)
                    completionHandler(memesData ?? MemesData())
                }
            })
            task.resume()
        }
    }
    
    func fetchMemeImage(url: String, completionHandler: @escaping (MemeImage) -> Void) {
        let imageUrl = URL(string: url)
        let session = URLSession.shared
        
        if let URL = imageUrl{
            let task = session.dataTask(with: URL, completionHandler: {data, response, error in
                print(response?.description ?? "")
                if let data = data {
                    let image = UIImage(data: data)
                    let memeImage = MemeImage(image: image ?? UIImage(), url: url)
                    completionHandler(memeImage)
                }
                
            })
            task.resume()
        }
        
    }
    
    func fetchCaptionImage(captionImageData: CaptionImageRequestData, completionHandler: @escaping (UIImage) -> Void){
        let session = URLSession.shared
        
        var request = URLRequest(url: getCaptionImageURL)
        request.httpMethod = "POST"
        
        var components = URLComponents(url: getCaptionImageURL, resolvingAgainstBaseURL: false)!
        
        let templateID:String = captionImageData.template_id!
        let username:String = captionImageData.username!
        let password:String = captionImageData.password!
        
        components.queryItems = [
            URLQueryItem(name: "template_id", value: "\(templateID)"),
            URLQueryItem(name: "username", value: "\(username)"),
            URLQueryItem(name: "password", value: "\(password)")
        ]
        
        var i = 0
        for box in captionImageData.boxes {
            components.queryItems?.append(URLQueryItem(name: "boxes[\(i)][text]", value: box))
            i += 1
        }
        
        let query = components.url!.query
        
        request.httpBody = Data(query!.utf8)
        
        let task = session.dataTask(with: request,completionHandler: { data, response, error in
            print(response?.description ?? "")
            
            if let data = data{
                let imageData = try? JSONDecoder().decode(CaptionImageResponseData.self, from: data)
                
                self.fetchMemeImage(url: imageData?.data?.url ?? "", completionHandler: { [weak self] (newImage) in
                    completionHandler(newImage.image ?? UIImage())
                })
            }
            print(error.debugDescription)
            
        })
        task.resume()

    }
    
}
