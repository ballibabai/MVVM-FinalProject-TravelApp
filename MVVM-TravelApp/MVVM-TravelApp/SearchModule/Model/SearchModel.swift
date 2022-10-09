//
//  SearchModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 5.10.2022.
//

import Foundation

protocol searchModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

final class SearchModel {

    weak var delegate: searchModelProtocol?
    
    var hotels = [Hotel]()
    var flight = [Flight]()
    
    
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
    
    func flightData(){
        guard let path = Bundle.main.path(forResource: "flightssData", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(FlightRecord.self, from: data)
            if let array = result.flightss{
                flight = array
                delegate?.didDataFetchProcessFinish(true)
               // print("deenemeee")
            }
            
        }catch {
            print("eerorrr model11")
            delegate?.didDataFetchProcessFinish(false)
        }
        
    }

}
