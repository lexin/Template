//
//  StorageProvider.swift
//  Template
//
//  Created by Oleksii Romanko on 25.05.2022.
//

import Foundation
import CoreData

struct StorageError: Error {
    var localizedDescription: String {
        return message
    }

    var message = ""
}

protocol StorageProviderProtocol {
  associatedtype T
  func save(items: [T], storageClassName: String, uniqueById: Bool, completion: @escaping (_ items: Result<[T]>) -> ())
  //func fetch(completion: @escaping (_ items: Result<[T]>) -> ())
}

class StorageProvider: StorageProviderProtocol {
  typealias T = BasicObject

  let persistentContainer : NSPersistentContainer

  internal init(persistentContainer: NSPersistentContainer) {
    self.persistentContainer = persistentContainer
  }

  func save(items: [T], storageClassName: String, uniqueById: Bool, completion: @escaping (_ items: Result<[T]>) -> ()) {
    let managedObjectContext = self.persistentContainer.viewContext

    let managedObjects = items.map { $0.parseToManagedObject(in: managedObjectContext,
                                                             to: storageClassName,
                                                             uniqueFetchRequest:  uniqueById ? $0.fetchRequestById(id: Int32($0.id)) : nil)}
    do {
      let managedObjects = managedObjects as [NSManagedObject?]
      try CoreDataStack.shared.save(managedObjects: managedObjects, managedObjectContext: managedObjectContext)
      completion(.success(items)) // - from API
    } catch {
        completion(.failure(StorageError(message: "Failed saving the context")))
    }
  }

//  func fetch(completion: @escaping (_ items: Result<[T]>) -> ()) {
//    let syncContext = persistentContainer.viewContext
//    do
//    {
//      let coursesManagedObjects = try syncContext.fetch(T.fetchRequest())
//      let courses = coursesManagedObjects.compactMap { courseObject in
//        courseObject.toModel()
//      }
//      completion(.success(courses))
//    } catch {
//      completion(.failure(StorageError(message: "Core Data fetching issue")))
//    }
//  }

}

