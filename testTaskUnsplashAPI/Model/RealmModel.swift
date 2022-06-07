//
//  RealmModel.swift
//  testTaskUnsplashAPI
//
//  Created by gleba on 06.05.2022.
//
import RealmSwift
import Foundation

class PictureObject: Object{
    @objc dynamic var id: String?
    @objc dynamic var view: Data?
    @objc dynamic var userName: String?
    @objc dynamic var date: String?
    @objc dynamic var location: String?
    @objc dynamic var likes: String?
}


