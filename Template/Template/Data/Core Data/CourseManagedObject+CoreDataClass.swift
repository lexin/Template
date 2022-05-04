//
//  CourseManagedObject+CoreDataClass.swift
//  
//
//  Created by Oleksii Romanko on 26.04.2022.
//
//

import Foundation
import CoreData

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
      return Course(id: Int(id), numberOfLessons: 0, name: name ?? "unknowb", link: "", imageURL: imageUrl ?? "")
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
