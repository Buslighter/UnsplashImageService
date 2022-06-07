//
//  Pictures.swift
//  testTaskUnsplashAPI
//
//  Created by gleba on 30.04.2022.
//

import Foundation

class Answer: Codable{
    var results : [Result]
    var total: Int
}
class Result : Codable{
    var created_at: String
    var id: String
    var likes: Int
    var urls: URLs
    var user: User
}

class User: Codable{
    
    var location: String?
    var name: String
}
class URLs: Codable{
    var regular: String
}

class DeResult{
    var realmObj: PictureObject? 
}
