//
//  CourseManagedObject+CoreDataProperties.swift
//  
//
//  Created by Oleksii Romanko on 26.04.2022.
//
//

import Foundation
import CoreData


extension CourseManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CourseManagedObject> {
        return NSFetchRequest<CourseManagedObject>(entityName: "CourseManagedObject")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?

}
