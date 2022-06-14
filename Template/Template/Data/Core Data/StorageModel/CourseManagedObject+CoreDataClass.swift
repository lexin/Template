//
//  CourseManagedObject+CoreDataClass.swift
//  
//
//  Created by Oleksii Romanko on 26.04.2022.
//
//

import Foundation
import CoreData

// It's best to decouple the application / business logic from persistence framework
// That's why CourseManagedObject - which is a NSManagedObject subclass

@objc(CourseManagedObject)
public class CourseManagedObject: NSManagedObject {

  static var entityName = "CourseManagedObject"
  var fullName: String {
    get {
      return "Full name = \(name)"
    }
  }
}


extension CourseManagedObject: ModelConvertible {
    // MARK: - ModelConvertible
    /// Converts a CourseManagedObject instance to a Course instance.
    ///
    /// - Returns: The converted Course instance.
    func toModel() -> Course? {
      return Course(id: Int(id), numberOfLessons: 0, name: (name ?? "unknown") + "_db", link: "", imageURL: imageUrl ?? "")
    }
}


extension CourseManagedObject {
  @nonobjc public class func fetchRequest(id:Int32) -> NSFetchRequest<CourseManagedObject> {
    let fetchRequest = CourseManagedObject.fetchRequest()
    fetchRequest.predicate = NSPredicate(
        format: "id = %@", "\(id)"
    )
      return fetchRequest
  }

}
extension CourseManagedObject {
func populate(with parameters: AddCourseParameters) {
    // Normally this id should be used at some point during the sync with the API backend
    id = Int32(arc4random() % 100_000)// NSUUID().uuidString

    name = parameters.name
  	//numberOfLessons = parameters.numberOfLessons

}

}
