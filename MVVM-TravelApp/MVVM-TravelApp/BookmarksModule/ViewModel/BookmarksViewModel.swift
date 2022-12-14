//
//  BookmarksViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 7.10.2022.
//

import Foundation

protocol BookmarksViewModelProtocol: AnyObject {
    func didCellFetchToDo(_ isSuccess: Bool)
}

final class BookmarksViewModel {
    
    weak var bookmarksVMDelegate: BookmarksViewModelProtocol?
    private let bookmarksModelInstance = BookmarksModel()
    
    init(){
        bookmarksModelInstance.bookmarksModelDelegate = self
    }
 
    func didViewLoad() -> [BookmarkData]{
        bookmarksModelInstance.getData()
        return bookmarksModelInstance.coreDataEntity
    }
    
    func numberOfSections() -> Int {1}
    
    func numberOfItems() -> Int {
        return bookmarksModelInstance.coreDataEntity.count
    }
    
    func getDetailDataForAllData(at index:Int) -> AllDataEntity {
        return transformCoreDataToAllData(bookmarksModelInstance.coreDataEntity[index])
    }

    func transformCoreDataToAllData(_ coreData: BookmarkData) -> AllDataEntity{
        return .init(id: coreData.dataId, category: "", images: coreData.dataImage, description: coreData.dataDescription, title: coreData.dataTitle)
    }
}

extension BookmarksViewModel: BookmarksModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            bookmarksVMDelegate?.didCellFetchToDo(true)
               }else {
                   print("Errorr View Modellll")
                   bookmarksVMDelegate?.didCellFetchToDo(false)
               }
        }
}
