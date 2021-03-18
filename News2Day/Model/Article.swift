//
//  Article.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/18.
//

import Foundation

struct Article: Decodable {
    
    var author: String?
    var title: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?
    var description:String?
    
}
