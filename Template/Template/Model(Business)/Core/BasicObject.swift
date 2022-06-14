//
//  BasicObject.swift
//  Template
//
//  Created by Oleksii Romanko on 27.05.2022.
//

import Foundation
import CoreData

class BasicObject:  Codable, Equatable, Identifiable {
  var id: Int

  internal init(id: Int) {
    self.id = id

  }
  static func == (lhs: BasicObject, rhs: BasicObject) -> Bool {
    lhs.id == rhs.id
  }

  enum CodingKeys: String, CodingKey {
         case id
     }


  func fetchRequestWithId() -> NSFetchRequest<NSManagedObject>? {
    fatalError("need to override in a child")
  }


  func parse(in context: NSManagedObjectContext, to entityName: String, uniqueFetchRequest: NSFetchRequest<NSManagedObject>? = nil) -> NSManagedObject? {

    guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
      NSLog("Can't create entity \(entityName)")
      return nil
    }
    if let fetchRequest = uniqueFetchRequest {
      do {
        let storedObjects = try context.fetch(fetchRequest)
        if let storedObject = storedObjects.first {
          setProperties(object: storedObject)//update entity
          return storedObject
        }
      } catch {

      }
    }
    let object = CourseManagedObject.init(entity: entityDescription, insertInto: context)
    setProperties(object: object)

    return object
  }


  func setProperties (object: NSManagedObject) {
    fatalError("need to override in a child")
  }

}

extension BasicObject: ManagedObjectConvertibleProtocol {
   func fetchRequestById(id: Int32) -> NSFetchRequest<NSManagedObject>? {
    self.fetchRequestWithId()
  }

  static func fetchRequest() -> NSFetchRequest<NSManagedObject>? {
    return CourseManagedObject.fetchRequest() as? NSFetchRequest<NSManagedObject>
  }

  func parseToManagedObject(in context: NSManagedObjectContext, to entityName: String, uniqueFetchRequest: NSFetchRequest<NSManagedObject>? = nil) -> NSManagedObject?  {
    self.parse(in: context, to: entityName, uniqueFetchRequest: uniqueFetchRequest)
  }
}
