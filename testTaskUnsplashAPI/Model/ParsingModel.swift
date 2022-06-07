//
//  ParsingModel.swift
//  testTaskUnsplashAPI
//
//  Created by gleba on 30.04.2022.
//

import Foundation


class Parse{
    func getData(searchText: String,numberOfPictures: Int ,completion: @escaping (Answer) -> Void){
        var results : Answer?
        let token = "jdnWggMJmgcXRZ2cpQOGl2HqkgvHcwir4hxMOw7KvYM"
        let random = Int.random(in: 0...999)
        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText)?sig=\(random)&per_page=\(numberOfPictures)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
//                    let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
//                    print(jsonData)
                    let res = try decoder.decode(Answer.self, from: data!)
                    results = res
                } catch{
                    print("\(error) error happened")
                }
            }
            DispatchQueue.main.async {
                completion(results!)
            }
        }
        task.resume()
    }
}


