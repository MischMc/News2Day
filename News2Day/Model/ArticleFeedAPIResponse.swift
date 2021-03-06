//
//  ArticleService.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/18.
//

import Foundation

struct ArticleFeedAPIResponse:Decodable {
    var totalResults: Int
    var articles: [Article]
}
