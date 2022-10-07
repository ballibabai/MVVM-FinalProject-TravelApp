//
//  SearchViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 5.10.2022.
//

import Foundation

protocol searchViewModelProtocol: AnyObject {
    func didCellItemFetch(_ isSuccess: Bool)
   // func navigateDetail(_ id: Int)
}

final class SearchViewModel {
    
    weak var searchViewModelDelegate: searchViewModelProtocol?
    private let searchModelInstance = SearchModel()
    var vmEnumTpye: whichButton = .hotel
    var searchListHotel = [Hotel]()
    var searchListFlight = [Flight]()
    
    init(){
        searchModelInstance.delegate = self
    }
    
    func didViewLoad(){
        if vmEnumTpye == .hotel {
            searchModelInstance.hotelData()
        }
    }
    func didViewLoadFlight(){
        if vmEnumTpye == .flight {
            searchModelInstance.flightData()
        }
    }
    func numberOfSections() -> Int {1}
    
    func getListHotel() -> [AllDataEntity] {
        if vmEnumTpye == .hotel {
         return transformSearchListHotel(searchModelInstance.hotels)
        }
        return [.init(id: 0, category: "", images: "", description: "", title: "")]
    }
    func getListFlight() -> [AllDataEntity] {
        if vmEnumTpye == .flight {
            return transformSearchListFlight(searchModelInstance.flight)
        }
        return [.init(id: 0, category: "", images: "", description: "", title: "")]
    }
    
    func transformSearchListHotel(_ hotel: [Hotel]) -> [AllDataEntity] {
        return searchListHotel.map{.init(id: $0.id!, category: $0.website, images: $0.image, description: $0.description, title: $0.name)}
    }
    func transformSearchListFlight(_ flight: [Flight]) -> [AllDataEntity] {
        return searchListFlight.map{.init(id: $0.id!, category: $0.deperture_airport, images: $0.image, description: $0.arrival, title: $0.flightNumber)}
      //rn self.searchListFlight.map{.init(id: $0.id!, image: $0.image!, name: $0.flightNumber!, //description: $0.deperture_airport!)}
    }
    
//    func didClickItem(at index: Int){
//        if vmEnumTpye == .hotel {
//            let selectedItem = searchListHotel[index]
//            searchViewModelDelegate?.navigateDetail(selectedItem.id!)
//        }else {
//            let selectedItem = searchListFlight[index]
//            searchViewModelDelegate?.navigateDetail(selectedItem.id!)
//        }
//      }
    
//    func getListHotelToDetail(at index: Int) -> SearchEntity {
//        return transfromArticleToArticleEntity(searchListHotel[index])
//    }
//    func getListFlightToDetail(at index: Int) -> SearchEntity {
//        return transfromArticleToArticleEntity(searchListFlight[index])
//    }
//
//    func transfromArticleToArticleEntity(_ flight: Flight) -> SearchEntity{
//
//        return .init(image: flight.image, name: flight.flightNumber, description: flight.deperture_airport)
//
//    }
//
//    func transfromArticleToArticleEntity(_ hotel: Hotel) -> SearchEntity{
//
//        return .init(image: hotel.image, name: hotel.name, description: hotel.description)
//   }
    
}

extension SearchViewModel: searchModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess{
            searchListHotel = searchModelInstance.hotels
            searchListFlight = searchModelInstance.flight
            searchViewModelDelegate?.didCellItemFetch(true)
        }else{
            print("error SearchVM")
            searchViewModelDelegate?.didCellItemFetch(false)
        }
    }
    
    
}
