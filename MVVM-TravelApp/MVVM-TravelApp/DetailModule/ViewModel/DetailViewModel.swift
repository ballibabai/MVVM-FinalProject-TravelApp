//
//  DetailViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation

protocol DetailViewModelProtocol: AnyObject {
    func didFetchDataFromCoreData(_ isSuccess: Bool)
}

final class DetailViewModel {
    
    weak var detailVMDelegate: DetailViewModelProtocol?
    private let detailModelInstance = DetailModel()
    var dataAll4 = [BookmarkData]()
    
    init(){
        detailModelInstance.detailModelDelegate = self
    }
    
    
//    func didDeleteFromCoreData(_ id: Int){
//        detailModelInstance.deleteDataFromCoreData(id)
//      }
    func didDeleteDataFromCoreData(_ data: String){
        detailModelInstance.coreDataDelete(data)
    }
    func saveButtonTapped(titleText: String, descriptionText: String, imageView: String){
        
        detailModelInstance.fetchData(titleText: titleText, descriptionText: descriptionText, imageView: imageView)
    }
    
}

extension DetailViewModel: DetailModelProtocol {
    func didFetchDataFromCoreData(_ isSuccess: Bool) {
        if isSuccess{
            self.dataAll4 = detailModelInstance.dataAll3
        }
    }
    
    
}
