//
//  BookmarksModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 7.10.2022.
//

import Foundation
import CoreData
protocol BookmarksModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}


final class BookmarksModel {
    weak var bookmarksModelDelegate: BookmarksModelProtocol?
   
    var coreDataEntity = [BookmarkData]()
   
   //The function for to show the added data on the screen
    func getData(){
       let fetchRequest: NSFetchRequest<BookmarkData> = BookmarkData.fetchRequest()
      // let sortByDate = NSSortDescriptor(key: #keyPath(BookmarkData.date), ascending: false)
      // fetchRequest.sortDescriptors = [sortByDate]
       do {
           let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
           let results = try context.fetch(fetchRequest)
           coreDataEntity = results
           
           bookmarksModelDelegate?.didDataFetchProcessFinish(true)
       }catch{
           bookmarksModelDelegate?.didDataFetchProcessFinish(false)
           print("errorrr Fetchh")
       }
   }
}
