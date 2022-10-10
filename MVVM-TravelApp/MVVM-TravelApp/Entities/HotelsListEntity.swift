//
//  HotelsListEntity.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 5.10.2022.
//

import Foundation


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
