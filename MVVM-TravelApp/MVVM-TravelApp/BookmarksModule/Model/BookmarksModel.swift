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
   
   var searchEntity = [SearchEntity]() // ToDoListModuleEntity is from CoreData
   
   //The function for to show the added data on the screen
   func getData() {
       let fetchRequest: NSFetchRequest<BookmarkData> = BookmarkData.fetchRequest()
      // let sortByDate = NSSortDescriptor(key: #keyPath(BookmarkData.date), ascending: false)
      // fetchRequest.sortDescriptors = [sortByDate]
       do {
           let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
           let results = try context.fetch(fetchRequest)
           searchEntity = results.map{.init(image: $0.dataImage, name: $0.dataTitle, description: $0.dataDescription)}
           bookmarksModelDelegate?.didDataFetchProcessFinish(true)
       }catch{
           bookmarksModelDelegate?.didDataFetchProcessFinish(false)
           print("errorrr Fetchh")
       }
   }
   
   //Swipe
//eteSwipe(_ index: Int){
//emove the newToDoData[index] from the CoreData
//elegate.sharedAppDelegate.coreDataStack.managedContext.delete(self.newToDoData[index])
//ave Changes
//elegate.sharedAppDelegate.coreDataStack.saveContext()
//fetchRequest: NSFetchRequest<ToDoListModuleEntity> = ToDoListModuleEntity.fetchRequest()
//.newToDoData = try! AppDelegate.sharedAppDelegate.coreDataStack.managedContext.fetch(fetchRequest)
//
}
