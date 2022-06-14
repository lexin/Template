//
//  CoreDataStack.swift
//  Template
//
//  Created by Oleksii Romanko on 22.05.2022.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext()
}


class CoreDataStack {

  static let shared = CoreDataStack()
  // MARK: - CoreData stack

  lazy var persistentContainer: NSPersistentContainer = {
      /*
       The persistent container for the application. This implementation
       creates and returns a container, having loaded the store for the
       application to it. This property is optional since there are legitimate
       error conditions that could cause the creation of the store to fail.
      */
      let container = NSPersistentContainer(name: "Template")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

              /*
               Typical reasons for an error here include:
               * The parent directory does not exist, cannot be created, or disallows writing.
               * The persistent store is not accessible, due to permissions or data protection when the device is locked.
               * The device is out of space.
               * The store could not be migrated to the current model version.
               Check the error message to determine what the actual problem was.
               */
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - CoreData Saving support

  func saveContext() {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate.
              // You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }

  // MARK: - CoreData saving objects
  func save (managedObjects: [NSManagedObject?], managedObjectContext: NSManagedObjectContext) throws {
    do {
      try managedObjectContext.save()
    } catch {
      for object in managedObjects {
        if let o = object {
          managedObjectContext.delete(o)
        }
      }
      throw error
    }
  }



}



protocol NSManagedObjectContextProtocol {
    func allEntities<T: NSManagedObject>(withType type: T.Type) throws -> [T]
    func allEntities<T: NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> [T]
    func addEntity<T: NSManagedObject>(withType type : T.Type) -> T?
    func save() throws
    func delete(_ object: NSManagedObject)
}

extension NSManagedObjectContext: NSManagedObjectContextProtocol {
    func allEntities<T: NSManagedObject>(withType type: T.Type) throws -> [T] {
        return try allEntities(withType: type, predicate: nil)
    }

    func allEntities<T : NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: T.description())
        request.predicate = predicate
        let results = try self.fetch(request)

        return results
    }

    func addEntity<T : NSManagedObject>(withType type: T.Type) -> T? {
        let entityName = T.description()

        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: self) else {
            return nil
        }

        let record = T(entity: entity, insertInto: self)

        return record
    }
}
