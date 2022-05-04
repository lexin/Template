//
//  Course.swift
//  Template
//
//  Created by Alexey Romanko on 17.04.2022.
//

import Foundation
import CoreData

struct Course: Codable, Equatable, Identifiable {

  typealias Model = Course

  enum CodingKeys: String, CodingKey {
         case imageURL = "imageUrl" //different spelling !
         case id
         case name
         case link
         case numberOfLessons
     }
  let id: Int
  let numberOfLessons: Int
  let name, link, imageURL: String

}

extension Course: ManagedObjectConvertible {
  func parseToManagedObject(in context: NSManagedObjectContext, uniqueFetchRequest: NSFetchRequest<CourseManagedObject>? = nil) -> CourseManagedObject? {
    let entityName = CourseManagedObject.entityName
    guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
      NSLog("Can't create entity \(entityName)")
      return nil
    }
    if let fetchRequest = uniqueFetchRequest {
      do {
        let storedObjects = try context.fetch(fetchRequest)
        if let storedObject = storedObjects.first {
          setProperties(object: storedObject)
          return storedObject
        }
      } catch {

      }
    }
    let object = CourseManagedObject.init(entity: entityDescription, insertInto: context)
    setProperties(object: object)

    return object
  }

  func setProperties (object: CourseManagedObject) {
    object.id = Int32(id)
    object.name = name
    object.imageUrl = imageURL
  }

  
}
