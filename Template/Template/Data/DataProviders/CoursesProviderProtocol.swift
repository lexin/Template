//
//  DataProviderOld.swift
//  Template
//
//  Created by Oleksii Romanko on 17.04.2022.
//

import Foundation
import UIKit


typealias fetchCoursesCompletionHandler = (_ courses: Result<[Course]>) -> ()
typealias addCourseCompletionHandler = (_ course: Result<Course?>) -> Void


protocol CoursesProviderProtocol {
  func fetchCourses(completion: @escaping fetchCoursesCompletionHandler )
  func addCourse(courseParams: AddCourseParameters, completion: @escaping addCourseCompletionHandler)
}


struct AddCourseParameters {
    var name: String
    var numberOfLessons: Int
}

