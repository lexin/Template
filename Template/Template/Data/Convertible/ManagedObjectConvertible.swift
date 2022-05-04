//
//  ManagedObjectConvertible.swift
//  Template
//
//  Created by Oleksii Romanko on 26.04.2022.
//

import Foundation
import CoreData

/// Protocol to provide functionality for CoreData managed object conversion.
protocol ManagedObjectConvertible {
    associatedtype ManagedObject

    /// Converts a conforming instance to a managed object instance.
    ///
    /// - Parameter context: The managed object context to use.
    /// - Returns: The converted managed object instance.
    func  parseToManagedObject(in context: NSManagedObjectContext, uniqueFetchRequest: NSFetchRequest<CourseManagedObject>?) -> ManagedObject?

  	func setProperties (object: ManagedObject)
}
