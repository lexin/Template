//
//  Course.swift
//  Template
//
//  Created by Alexey Romanko on 17.04.2022.
//

import Foundation
import CoreData


class Course: BasicObject {
  let numberOfLessons: Int
  let name, link, imageURL: String

  internal init(id: Int, numberOfLessons: Int, name: String, link: String, imageURL: String) {

    self.numberOfLessons = numberOfLessons
    self.name = name
    self.link = link
    self.imageURL = imageURL
    super.init(id: id)
  }

  required init(from decoder: Decoder) throws {
    fatalError("init(from:) has not been implemented")
  }

  enum CodingKeys: String, CodingKey {
         case imageURL = "imageUrl" //different spelling !
         case id
         case name
         case link
         case numberOfLessons
     }

  override func fetchRequestWithId() -> NSFetchRequest<NSManagedObject>? {
    return CourseManagedObject.fetchRequest(id: Int32(id)) as? NSFetchRequest<NSManagedObject>
  }

  override func setProperties (object: NSManagedObject) {
    if let course = object as? CourseManagedObject {
      course.id = Int32(id)
      course.name = name
      course.imageUrl = imageURL
    }
  }
}




