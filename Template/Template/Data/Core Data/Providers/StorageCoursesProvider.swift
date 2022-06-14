//
//  StorageCoursesProvider.swift
//  Template
//
//  Created by Oleksii Romanko on 23.05.2022.
//

import Foundation
import CoreData
protocol StorageCoursesProviderProtocol: CoursesProviderProtocol {
  func save(courses: [Course], completion: @escaping fetchCoursesCompletionHandler)
}

class StorageCoursesProvider: StorageProvider, StorageCoursesProviderProtocol {

  func save(courses: [Course], completion: @escaping fetchCoursesCompletionHandler) {
    self.save(items: courses, storageClassName: CourseManagedObject.entityName, uniqueById: true) { result in
      switch result {
      case .success(courses):
        completion(.success(courses))
      case .failure(_):
        completion(.failure(StorageError(message: "Failed saving the context")))
      case .success(_):
        completion(.success([]))
      }
    }

  }
  func fetchCourses(completion: @escaping fetchCoursesCompletionHandler) {
    let syncContext = persistentContainer.viewContext
    do
    {
      let coursesManagedObjects = try syncContext.fetch(CourseManagedObject.fetchRequest())
      let courses = coursesManagedObjects.compactMap { courseObject in
        courseObject.toModel()
      }
      completion(.success(courses))
    } catch {
      completion(.failure(StorageError(message: "Core Data fetching issue")))
    }
  }

  func addCourse(courseParams: AddCourseParameters, completion: @escaping addCourseCompletionHandler) {
    let syncContext = persistentContainer.viewContext
    guard let coreDataCourse = syncContext.addEntity(withType: CourseManagedObject.self) else {
      completion(.failure(StorageError(message: "Failed adding the course in the data base")))
      return
    }
    coreDataCourse.populate(with: courseParams)
    do {
      try syncContext.save()
      completion(.success(coreDataCourse.toModel()))
    } catch {
      syncContext.delete(coreDataCourse)
      completion(.failure(StorageError(message: "Failed saving the context")))
    }
  }

}
