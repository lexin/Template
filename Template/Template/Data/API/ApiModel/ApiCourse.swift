//
//  ApiCourse.swift
//  Template
//
//  Created by Oleksii Romanko on 22.05.2022.
//

import Foundation
// If structure of module is simple and constant then it's relatively safe to have a single representation
// for both the API entities and your core entities(business).
struct ApiCourse: Codable, Equatable, Identifiable {

  enum CodingKeys: String, CodingKey {
         case imageURL = "imageUrl" //different spelling !
         case id
         case name
         case link
         case numberOfLessons
     }
  let id: Int
  let numberOfLessons: Int
  let name, link, imageURL: String

}

extension ApiCourse: ModelConvertible {

  // MARK: - ModelConvertible
  /// Converts a ApiCourse instance to a Course instance.
  ///
  /// - Returns: The converted Course instance.
  func toModel() -> Course? {
    return Course(id: id,
                  numberOfLessons: numberOfLessons,
                  name: name,
                  link: link,
                  imageURL: imageURL)
  }


}
