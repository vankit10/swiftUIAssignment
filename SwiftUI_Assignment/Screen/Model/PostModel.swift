//
//  PostModel.swift
//  SwiftUI_Assignment
//
//  Created by Ankit on 02/10/25.
//

import Foundation

struct PostModel : Codable {
    var body : String?
    var id : Int?
    var title : String?
    var userId : Int?
}

struct FavoritePostModel: Codable {
    var id: Int?
    var userId: Int?
    var title: String?
    var body: String?
}
