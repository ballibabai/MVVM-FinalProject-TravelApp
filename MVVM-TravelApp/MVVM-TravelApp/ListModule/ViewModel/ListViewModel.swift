//
//  ListViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 5.10.2022.
//

import Foundation

protocol ListViewModelProtocol: AnyObject {
    func didCellItemFetch(_ isSuccess: Bool)
}

final class ListViewModel {
    
    weak var ListViewModelDelegate: ListViewModelProtocol?
    private var hotelFlighInstance = HotelFlightModel()
    var vmEnumType: whichButton?
    
    init(){
        hotelFlighInstance.delegate = self
    }
    
    func didViewLoad(){
        if vmEnumType == .flight {
            hotelFlighInstance.flightData()
        }else{
            hotelFlighInstance.hotelData()
        }
        
    }
    
    func numberOfSections() -> Int {1}
    
    func numberOfItemsHotel() -> Int {
        return hotelFlighInstance.hotels.count
    }
    func numberOfItemsFlight() -> Int {
        return hotelFlighInstance.flight.count
    }
    func getListHotel(at index: Int) -> AllDataEntity {
        return transfromHotelToAllDataEntity(hotelFlighInstance.hotels[index])
    }
    func getListFlight(at index: Int) -> AllDataEntity {
        return transfromFlightToAllDataEntity(hotelFlighInstance.flight[index])
    }
    
   private func transfromHotelToAllDataEntity(_ hotel: Hotel) -> AllDataEntity{
       
        return .init(id: hotel.id!, category: hotel.website, images: hotel.image, description: hotel.description, title: hotel.name)
   }
    
   private func transfromFlightToAllDataEntity(_ flight: Flight) -> AllDataEntity{
       
        return .init(id: flight.id!, category: flight.deperture_airport, images: flight.image, description: flight.arrival, title: flight.flightNumber)
   }
}


extension ListViewModel: ListModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            ListViewModelDelegate?.didCellItemFetch(true)
        }else {
            print("errorrr listViewModel")
            ListViewModelDelegate?.didCellItemFetch(false)
        }
    }
    
    
}
