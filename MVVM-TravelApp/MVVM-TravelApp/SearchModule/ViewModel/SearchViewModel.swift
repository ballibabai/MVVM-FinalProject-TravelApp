//
//  SearchViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 5.10.2022.
//

import Foundation

protocol searchViewModelProtocol: AnyObject {
    func didCellItemFetch(_ isSuccess: Bool)
}

final class SearchViewModel {
    
    weak var searchViewModelDelegate: searchViewModelProtocol?
    private let searchModelInstance = SearchModel()
    var vmEnumTpye: whichButton = .hotel

    init(){
        searchModelInstance.delegate = self
    }
    
    func didViewLoad(){
        if vmEnumTpye == .hotel {
            searchModelInstance.hotelData()
        }else {
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
    
  private  func transformSearchListHotel(_ hotel: [Hotel]) -> [AllDataEntity] {
        return searchModelInstance.hotels.map{.init(id: $0.id!, category: $0.website, images: $0.image, description: $0.description, title: $0.name)}
    }
  private func transformSearchListFlight(_ flight: [Flight]) -> [AllDataEntity] {
        return searchModelInstance.flight.map{.init(id: $0.id!, category: $0.deperture_airport, images: $0.image, description: $0.arrival, title: $0.flightNumber)}
    }
   
}

//MARK: - Extension
extension SearchViewModel: searchModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess{
            searchViewModelDelegate?.didCellItemFetch(true)
        }else{
            print("error SearchVM")
            searchViewModelDelegate?.didCellItemFetch(false)
        }
    }
    
    
}
