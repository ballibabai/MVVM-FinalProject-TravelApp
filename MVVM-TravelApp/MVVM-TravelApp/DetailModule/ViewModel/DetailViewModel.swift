//
//  DetailViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation

protocol DetailViewModelProtocol: AnyObject {
    func didCoreDataFetch(_ isSuccess: Bool)
    func didRemoveFromCoreData(_ isSuccess: Bool)
    func didAddToCoreData(_ isSuccess: Bool)
}

final class DetailViewModel {
    
    weak var detailVMDelegate: DetailViewModelProtocol?
    private let detailModelInstance = DetailModel()
    
    init(){
        detailModelInstance.detailModelDelegate = self
    }

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
            detailVMDelegate?.didCoreDataFetch(true)
        }else{
            print("errorrr DetailVM")
            detailVMDelegate?.didCoreDataFetch(false)
        }
    }
    
    
}
