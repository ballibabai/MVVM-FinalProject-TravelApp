//
//  HotelsListEntity.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 5.10.2022.
//

import Foundation


enum whichButton: String {
    case flight = "Flight"
    case hotel = "Hotel"
    case article = "Article"
}

struct HotelList {
    let image: String?
    let name: String?
    let description: String?
}

struct Hotel: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let image: String?
    let website: String?
}

struct HotelsRecord: Decodable {
    let hotelss: [Hotel]?
}
