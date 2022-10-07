//
//  BookmarksViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 7.10.2022.
//

import Foundation

protocol BookmarksViewModelProtocol: AnyObject {
    func didCellFetchToDo(_ bookData: [BookmarkData])
}

final class BookmarksViewModel {
    
    weak var bookmarksVMDelegate: BookmarksViewModelProtocol?
    private let bookmarksModelInstance = BookmarksModel()
    
    var entityData = [BookmarkData]()
    
    init(){
        bookmarksModelInstance.bookmarksModelDelegate = self
    }
 
    func didViewLoad() -> [BookmarkData]{
        bookmarksModelInstance.getData()
        entityData = bookmarksModelInstance.coreDataEntity
        return entityData
    }
}

extension BookmarksViewModel: BookmarksModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            let dataAll = bookmarksModelInstance.coreDataEntity
            //let dataAll = bookmarksModelInstance.searchEntity
            bookmarksVMDelegate?.didCellFetchToDo(dataAll)
               }else {
                   print("Errorr View Modellll")
               }
           }
    
}
