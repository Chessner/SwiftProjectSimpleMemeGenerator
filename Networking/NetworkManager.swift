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
    
    func fetchCaptionImage(captionImageData: CaptionImageData, completionHandler: @escaping (UIImage) -> Void){
        let session = URLSession.shared
        
        var request = URLRequest(url: getCaptionImageURL)
        request.httpMethod = "POST"
       // request.httpBody
        //let templateID:String = captionImageData.template_id!
        
        //let postString = "\(templateID)&text0=Hello&text1=Hi&username=swiftproject2021memegenerator&password=swiftproject2021memegenerator"
        
        //request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let jsonData:Data = try! JSONEncoder().encode(captionImageData)
        request.httpBody? = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request,completionHandler: { data, response, error in
            print(response?.description ?? "")
            
            if let data = data{
                print(String(decoding: data, as: UTF8.self))
            }
            print(error.debugDescription)
            
        })
        task.resume()
//        let task = session.dataTask(with: request, completionHandler: { data, response, error in
//            print(response?.description ?? "")
//
//            if let data = data{
//                print(String(decoding: data, as: UTF8.self))
//            }
//            print(error.debugDescription)
//        })
//        task.resume()
    }
    
}
