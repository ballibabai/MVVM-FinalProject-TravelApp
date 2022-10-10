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
    
    //There ara two data, one: MockData  two: ApiData
    func didViewLoad(){
        if vmEnumType == .flight {
            hotelFlighInstance.flightData() //for mockData
            //hotelFlighInstance.flightsApiFetch() //for Api Request
        }else{
            hotelFlighInstance.hotelData()
        }
    }
    func numberOfSections() -> Int {1}
    
    func numberOfItemsHotel() -> Int {
        return hotelFlighInstance.hotels.count
    }
    
    //There ara two data, one: MockData  two: ApiData
    func numberOfItemsFlight() -> Int {
        return hotelFlighInstance.flight.count   //for mockData
        //return hotelFlighInstance.flightForApi.count // for Api Request
    }
    func getListHotel(at index: Int) -> AllDataEntity {
        return transfromHotelToAllDataEntity(hotelFlighInstance.hotels[index])
    }
    
    //There ara two data, one: MockData  two: ApiData
    func getListFlight(at index: Int) -> AllDataEntity {
       return transfromFlightToAllDataEntity(hotelFlighInstance.flight[index]) //for mockData
       //return transfromFlightToAllDataEntity(hotelFlighInstance.flightForApi[index]) // for Api Request
    }
    
}

//MARK: - Extensions
private extension ListViewModel {
    func transfromHotelToAllDataEntity(_ hotel: Hotel) -> AllDataEntity{
         return .init(id: hotel.id!, category: hotel.website, images: hotel.image, description: hotel.description, title: hotel.name)
    }
     
    func transfromFlightToAllDataEntity(_ flight: Flight) -> AllDataEntity{
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
