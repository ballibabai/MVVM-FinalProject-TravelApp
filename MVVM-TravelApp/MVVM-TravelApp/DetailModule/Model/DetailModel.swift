//
//  DetailModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation
import CoreData

protocol DetailModelProtocol: AnyObject {
    func didFetchDataFromCoreData(_ isSuccess: Bool)
}

final class DetailModel {
    
    weak var detailModelDelegate: DetailModelProtocol?
    
    var dataAll3 = [BookmarkData]()
    
    func fetchData(titleText: String, descriptionText: String, imageView: String){
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let data = BookmarkData(context: managedContext)
            //data.setValue(UUID, forKey: #keyPath(BookmarkData.dataId))
            data.setValue(Int(), forKey: #keyPath(BookmarkData.dataId))
            data.setValue(imageView, forKey: #keyPath(BookmarkData.dataImage))
            data.setValue(titleText, forKey: #keyPath(BookmarkData.dataTitle))
            data.setValue(descriptionText, forKey: #keyPath(BookmarkData.dataDescription))
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
            detailModelDelegate?.didFetchDataFromCoreData(true)
        }
    
    func coreDataDelete(_ title: String){
        
        let request: NSFetchRequest<BookmarkData> = BookmarkData.fetchRequest()
        let predicate = NSPredicate(format: "dataTitle MATCHES[cd] %@", title)
        request.predicate = predicate
        
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let result = try context.fetch(request).first
                    
                    if let result = result {
                        context.delete(result)
                    }
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        }catch {
            print("errorrrrr deleteCoreData")
        }
        
    }
}
