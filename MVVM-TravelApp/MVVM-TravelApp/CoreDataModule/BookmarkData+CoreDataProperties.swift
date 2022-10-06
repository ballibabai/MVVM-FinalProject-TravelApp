//
//  BookmarkData+CoreDataProperties.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 6.10.2022.
//
//

import Foundation
import CoreData


extension BookmarkData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookmarkData> {
        return NSFetchRequest<BookmarkData>(entityName: "BookmarkData")
    }

    @NSManaged public var dataTitle: String?
    @NSManaged public var dataDescription: String?
    @NSManaged public var dataImage: String?

}

extension BookmarkData : Identifiable {

}
