//
//  HomeArticleEntity.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation

struct ArticleEntity {
    let id: Int?
    let category: String?
    let images: String?
    let description: String?
    let title: String?
}

struct Article: Decodable {
    let id: Int?
    let category: String?
    let images: String?
    let description: String?
    let title: String?
}

struct ArticleRecord: Decodable {
    let abc: [Article]?
}
