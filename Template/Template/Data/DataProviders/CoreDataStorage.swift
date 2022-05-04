//
//  CoreDataStorage.swift
//  Template
//
//  Created by Oleksii Romanko on 29.04.2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataStorage: DataProvider {
  //let persistentContainer : NSPersistentContainer
  let syncContext : NSManagedObjectContext

  internal init(/*persistentContainer: NSPersistentContainer, */syncContext: NSManagedObjectContext) {
    //self.persistentContainer = persistentContainer
    self.syncContext = syncContext
  }

  func fetchCourses(completion: @escaping ([Course]?, ErrorDataProviding?) -> () ) {
    do
    {
      let coursesManagedObjects = try syncContext.fetch(CourseManagedObject.fetchRequest())
      let courses = coursesManagedObjects.compactMap { course in
        course.toModel()
      }

      completion (courses, nil)
    } catch {
      completion (nil, ErrorDataProviding(text: "Core Data fetching issue"))
    }
  }

}
