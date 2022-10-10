//
//  HomeArticleModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation
import CoreData


protocol HomeArticleModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

final class HomeArticleModel {
    
    weak var delegate: HomeArticleModelProtocol?
    var articles = [Article]()
    var coreDataEntity = [BookmarkData]()
    
    func fetchData(){
        guard let path = Bundle.main.path(forResource: "HomeArticledata", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(ArticleRecord.self, from: data)
            if let array = result.articless{
                articles = array
                delegate?.didDataFetchProcessFinish(true)
            }
            
        }catch {
            print("eerorrr model")
            delegate?.didDataFetchProcessFinish(false)
        }
    }
    
    
    func fetchCoreData(titleText: String, descriptionText: String, imageView: String){
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let data = BookmarkData(context: managedContext)
            //data.setValue(UUID, forKey: #keyPath(BookmarkData.dataId))
            data.setValue(Int(), forKey: #keyPath(BookmarkData.dataId))
            data.setValue(imageView, forKey: #keyPath(BookmarkData.dataImage))
            data.setValue(titleText, forKey: #keyPath(BookmarkData.dataTitle))
            data.setValue(descriptionText, forKey: #keyPath(BookmarkData.dataDescription))
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
            delegate?.didDataFetchProcessFinish(true)
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
            delegate?.didDataFetchProcessFinish(true)
        }catch {
            print("errorrrrr deleteCoreData")
            delegate?.didDataFetchProcessFinish(false)
        }
        
    }
   
   //The function for to show the added data on the screen
    func getData(){
       let fetchRequest: NSFetchRequest<BookmarkData> = BookmarkData.fetchRequest()
      // let sortByDate = NSSortDescriptor(key: #keyPath(BookmarkData.date), ascending: false)
      // fetchRequest.sortDescriptors = [sortByDate]
       do {
           let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
           let results = try context.fetch(fetchRequest)
           coreDataEntity = results
           delegate?.didDataFetchProcessFinish(true)
       }catch{
           delegate?.didDataFetchProcessFinish(false)
           print("errorrr Fetchh")
       }
   }
    
}
