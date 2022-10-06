//
//  BookmarksViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 7.10.2022.
//

import Foundation

protocol BookmarksViewModelProtocol: AnyObject {
    func didCellFetchToDo(_ bookData: [SearchEntity])
}

final class BookmarksViewModel {
    
    weak var bookmarksVMDelegate: BookmarksViewModelProtocol?
    
    private let bookmarksModelInstance = BookmarksModel()
    
    
    init(){
        bookmarksModelInstance.bookmarksModelDelegate = self
    }
    
    func didViewLoad(){
        bookmarksModelInstance.getData()
    }
}

extension BookmarksViewModel: BookmarksModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            let dataAll = bookmarksModelInstance.searchEntity
            bookmarksVMDelegate?.didCellFetchToDo(dataAll)
               }else {
                   print("Errorr View Modellll")
               }
           }
    
}
