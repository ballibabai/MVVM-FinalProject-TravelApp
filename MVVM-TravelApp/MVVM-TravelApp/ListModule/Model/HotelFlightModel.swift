//
//  HotelFlightModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 5.10.2022.
//

import Foundation
import Alamofire

protocol ListModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

final class HotelFlightModel {

    weak var delegate: ListModelProtocol?
    
    var hotels = [Hotel]()
    var flight = [Flight]()
    var flightForApi = [Flight]()
    
func hotelData(){
    guard let path = Bundle.main.path(forResource: "HotelsData", ofType: "json") else {return}
    let url = URL(fileURLWithPath: path)
    
    do {
        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let result = try jsonDecoder.decode(HotelsRecord.self, from: data)
        if let array = result.hotelss{
            hotels = array
            delegate?.didDataFetchProcessFinish(true)
           // print("deenemeee")
        }
        
    }catch {
        print("eerorrr model11")
        delegate?.didDataFetchProcessFinish(false)
    }
    
}
//    
//    func flightData(){
//        guard let path = Bundle.main.path(forResource: "flightssData", ofType: "json") else {return}
//        let url = URL(fileURLWithPath: path)
//        
//        do {
//            let data = try Data(contentsOf: url)
//            let jsonDecoder = JSONDecoder()
//            let result = try jsonDecoder.decode(FlightRecord.self, from: data)
//            if let array = result.flightss{
//                flight = array
//                delegate?.didDataFetchProcessFinish(true)
//               // print("deenemeee")
//            }
//            
//        }catch {
//            print("eerorrr model11")
//            delegate?.didDataFetchProcessFinish(false)
//        }
//        
//    }
    
    func flightsApiFetch(){
        AF.request("https://app.goflightlabs.com/routes?access_key=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiZGM1ZGVhZTI4NDRkZTZmMTA3ZDI1NTZmOTc5ZDAwYjU2MmZmY2QxNmM0ZDdlZWVmYTQxMjZkY2ZmYTA5OTRkMDIzNmE4OTVmYWQ0NGZmZjQiLCJpYXQiOjE2NjU0MTE2MTksIm5iZiI6MTY2NTQxMTYxOSwiZXhwIjoxNjk2OTQ3NjE5LCJzdWIiOiIxNDc2NCIsInNjb3BlcyI6W119.J5yl3Ma-hZ3hla8ssrrgZDZueMlbNgqDOOBBd73pfms4_9pQB81uQoz6u68kSMUN9eo3y3yt3Tk8X27jkqLhLw&dep_iata=IST&arr_iata=ADB").response { [weak self ]response in
            guard let self = self else {return}
            
            do {
                guard let data = response.data else {return}
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(Flights.self, from: data)
                self.flightForApi = result.map{.init(id: 0, deperture_airport: $0.airline.name.rawValue, time: $0.arrival.time, arrival: $0.arrival.airport.rawValue, flightNumber: $0.flight.number, image: "https://cdn.pixabay.com/photo/2016/11/08/05/01/airplane-1807486_1280.jpg")}
                self.delegate?.didDataFetchProcessFinish(true)
            }catch{
                print("eerorrr model11")
                self.delegate?.didDataFetchProcessFinish(false)
            }
        }
    }

}
