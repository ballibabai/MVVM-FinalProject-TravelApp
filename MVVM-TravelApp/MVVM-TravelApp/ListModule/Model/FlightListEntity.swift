//
//  FlightListEntity.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 5.10.2022.
//

import Foundation

struct FlightList {
    let image: String?
    let name: String?
    let description: String?
}

struct Flight: Decodable {
    let deperture_airport: String?
    let time: String?
    let arrival: String?
    let flightNumber: String?
    let image: String?
}

struct FlightRecord: Decodable {
    let flightss: [Flight]?
}
