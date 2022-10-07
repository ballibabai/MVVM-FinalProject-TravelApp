//
//  ListViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 5.10.2022.
//

import Foundation

protocol ListViewModelProtocol: AnyObject {
    func didCellItemFetch(_ isSuccess: Bool)
    func navigateDetail(_ id: Int)
}

final class ListViewModel {
    
    weak var ListViewModelDelegate: ListViewModelProtocol?
    private var hotelFlighInstance = HotelFlightModel()
    var enumType: whichButton?
    
    init(){
        hotelFlighInstance.delegate = self
    }
    
    func didViewLoad(){
            hotelFlighInstance.flightData()
            hotelFlighInstance.hotelData()
    }
    
    func numberOfSections() -> Int {1}
    
    func numberOfItems() -> Int {
        return hotelFlighInstance.hotels.count
    }
    func numberOfItemsFlight() -> Int {
        return hotelFlighInstance.flight.count
    }
    func getList(at index: Int) -> AllDataEntity {
        return transfromArticleToArticleEntity(hotelFlighInstance.hotels[index])
    }
    func getListFlight(at index: Int) -> AllDataEntity {
        return transfromArticleToArticleEntity(hotelFlighInstance.flight[index])
    }
    
    func didClickItem(at index: Int){
        if enumType == .hotel {
            let selectedItem = hotelFlighInstance.hotels[index]
            ListViewModelDelegate?.navigateDetail(Int(selectedItem.id!))
        }else {
            let selectedItem = hotelFlighInstance.flight[index]
            ListViewModelDelegate?.navigateDetail(Int(selectedItem.id!))
        }
      }
    
    
    func transfromArticleToArticleEntity(_ hotel: Hotel) -> AllDataEntity{
       
        return .init(id: hotel.id!, category: hotel.website, images: hotel.image, description: hotel.description, title: hotel.name)
   }
    
    func transfromArticleToArticleEntity(_ flight: Flight) -> AllDataEntity{
       
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
