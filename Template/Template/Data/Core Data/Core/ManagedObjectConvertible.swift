//
//  ManagedObjectConvertible.swift
//  Template
//
//  Created by Oleksii Romanko on 26.04.2022.
//

import Foundation
import CoreData

/// Protocol to provide functionality for CoreData managed object conversion.
protocol ManagedObjectConvertibleProtocol {
    //associatedtype ManagedObject

  var id: Int {get}
  func fetchRequestById(id: Int32) -> NSFetchRequest<NSManagedObject>?
  //static func fetchRequestById(id:Int32) -> NSFetchRequest<NSManagedObject>
  static func fetchRequest() -> NSFetchRequest<NSManagedObject>?

    /// Converts a conforming instance to a managed object instance.
    ///
    /// - Parameter context: The managed object context to use.
  	/// entityName: Name of the object in CoreData
  	/// uniqueFetchRequest: Fetch request to filter during parsing
    /// - Returns: The converted managed object instance.
  func parseToManagedObject(in context: NSManagedObjectContext, to entityName: String, uniqueFetchRequest: NSFetchRequest<NSManagedObject>?) -> NSManagedObject?
  	//func setProperties (object: ManagedObject)

}
