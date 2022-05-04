//
//  Network.swift
//  Template
//
//  Created by Oleksii Romanko on 29.04.2022.
//

import Foundation
import UIKit
import CoreData

class Network: DataProvider {
  let persistentContainer : NSPersistentContainer
  let syncContext : NSManagedObjectContext

  internal init(persistentContainer: NSPersistentContainer, syncContext: NSManagedObjectContext) {
    self.persistentContainer = persistentContainer
    self.syncContext = syncContext
  }

  func fetchCourses(completion: @escaping ([Course]?, ErrorDataProviding?) -> () ) {
    let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"

    guard let url = URL(string: urlString) else {
      completion (nil, ErrorDataProviding(text: "wrong url"))
      return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in

      if let error = error {
        completion(nil, ErrorDataProviding(text: error.localizedDescription))
        return
      }

      if let resp = response as? HTTPURLResponse, resp.statusCode >= 300 {
        completion(nil, ErrorDataProviding(text: "Failed to hit endpoint with bad status code"))
        return
      }

      if let data = data {
        do {
          //let courses = try JSONDecoder().decode([Course].self, from: data)
          let courses = try Courses.decodeModel(from: data)

          let managedObjectContext = self.persistentContainer.viewContext

          _ = courses.map { $0.parseToManagedObject(in: managedObjectContext,
                                                    uniqueFetchRequest: CourseManagedObject.fetchRequest(id: Int32($0.id))) }
          try managedObjectContext.save()

          completion(courses, nil)
          return
        } catch {
          completion(nil, ErrorDataProviding(text: "Failed to reach endpoing:  \(error.localizedDescription)"))
          return
        }
      } else {
        completion(nil, ErrorDataProviding(text: "Failed to get data"))
        return
      }
    }.resume()

  }
}
