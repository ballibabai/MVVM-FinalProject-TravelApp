//
//  CoreDataStack.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 6.10.2022.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let modelName: String
    
    init(modelName: String){
        self.modelName = modelName // userInfo is a modelName
    }
    
    //create a storeContainer and access to CoreData
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error Container loading\(error.localizedDescription)")
            }
        }
        return container
    }()
    
    //NSManageObjectContext is mean Mock
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    
    //save data to CoreData
    func saveContext(){
        guard managedContext.hasChanges else{
            return
        }
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("error \(error)")
        }
    }
}
