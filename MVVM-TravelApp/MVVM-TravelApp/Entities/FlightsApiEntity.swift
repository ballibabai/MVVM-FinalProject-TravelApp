//
//  FlightsApiEntity.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 10.10.2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let flights = try? newJSONDecoder().decode(Flights.self, from: jsonData)

// MARK: - Flight
struct FlightApi: Codable {
    let departure, arrival: Arrival
    let airline: Airline
    let flight: FlightClass
}

// MARK: - Airline
struct Airline: Codable {
    let name: Name
    let callsign: Callsign
    let iata: AirlineIata
    let icao: AirlineIcao
}

enum Callsign: String, Codable {
    case atlasglobal = "ATLASGLOBAL"
    case onurAir = "ONUR AIR"
    case sunturk = "SUNTURK"
    case turkish = "TURKISH"
}

enum AirlineIata: String, Codable {
    case kk = "KK"
    case pc = "PC"
    case the8Q = "8Q"
    case tk = "TK"
}

enum AirlineIcao: String, Codable {
    case kkk = "KKK"
    case ohy = "OHY"
    case pgt = "PGT"
    case thy = "THY"
}

enum Name: String, Codable {
    case atlasjetAirlines = "Atlasjet Airlines"
    case onurAir = "Onur Air"
    case pegasusAirlines = "Pegasus Airlines"
    case thyTurkishAirlines = "THY - Turkish Airlines"
}

// MARK: - Arrival
struct Arrival: Codable {
    let airport: Airport
    let timezone: Timezone
    let iata: ArrivalIata
    let icao: ArrivalIcao
    let terminal: Terminal?
    let time: String?
}

enum Airport: String, Codable {
    case adnanMenderesAirport = "Adnan Menderes Airport"
    case istanbulAirport = "Istanbul Airport"
}

enum ArrivalIata: String, Codable {
    case adb = "ADB"
    case ist = "IST"
}

enum ArrivalIcao: String, Codable {
    case ltba = "LTBA"
    case ltbj = "LTBJ"
}

enum Terminal: String, Codable {
    case d = "D"
}

enum Timezone: String, Codable {
    case europeIstanbul = "Europe/Istanbul"
}

// MARK: - FlightClass
struct FlightClass: Codable {
    let number: String
}

typealias Flights = [FlightApi]
