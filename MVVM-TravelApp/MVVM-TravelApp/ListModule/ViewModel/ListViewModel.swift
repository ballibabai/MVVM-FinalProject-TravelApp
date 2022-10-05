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
    func getList(at index: Int) -> HotelList {
        return transfromArticleToArticleEntity(hotelFlighInstance.hotels[index])
    }
    func getListFlight(at index: Int) -> FlightList {
        return transfromArticleToArticleEntity(hotelFlighInstance.flight[index])
    }
    
    func didClickItem(at index: Int){
        let selectedItem = hotelFlighInstance.hotels[index]
        ListViewModelDelegate?.navigateDetail(selectedItem.id!)
        print(selectedItem)
      }
    
    
    func transfromArticleToArticleEntity(_ hotel: Hotel) -> HotelList{
       
        return .init(image: hotel.image, name: hotel.name, description: hotel.description)
   }
    
    func transfromArticleToArticleEntity(_ flight: Flight) -> FlightList{
       
        return .init(image: flight.image, name: flight.flightNumber, description: flight.deperture_airport)
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
