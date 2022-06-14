//
//  CourseDetailsPresenter.swift
//  Template
//
//  Created by Oleksii Romanko on 27.05.2022.
//

import Foundation

protocol CourseDetailsViewProtocol: AnyObject {
  func showCourse(course: Course) //or show each property in different methods

  func displayAddCourseError(title: String, message: String)
  // func showTitle(courseTitle: String)
  // func showImage(image: String)
}

protocol CourseDetailsPresenterProtocol {
  init(view: CourseDetailsViewProtocol, course: Course, dataProvider: CoursesProviderProtocol, router: CourseDetailsRouterProtocol)
  func showCourse()
  func didTapBack()
  func saveCourse(courseParams: AddCourseParameters)
}

class CourseDetailsPresenter: CourseDetailsPresenterProtocol {
  weak var view: CourseDetailsViewProtocol?

  var course: Course
  var router: CourseDetailsRouterProtocol
  let dataProvider: CoursesProviderProtocol

  required init(view: CourseDetailsViewProtocol, course: Course, dataProvider: CoursesProviderProtocol, router: CourseDetailsRouterProtocol) {
    self.view = view
    self.course = course
    self.router = router
    self.dataProvider = dataProvider
  }

  func showCourse() {
    view?.showCourse(course: course)
  }

  func didTapBack() {
    router.pop()
  }

  func saveCourse(courseParams: AddCourseParameters) {
    dataProvider.addCourse(courseParams: courseParams) { [weak self] result in
      switch result {
      case let .success(course) :
        self?.handleCourseAdded(course)
      case let .failure(error):
        self?.handleAddCourseError(error)
      }
      }
    }


  fileprivate func handleCourseAdded(_ course: Course?) {
    router.pop()
      //delegate?.addCoursePresenter(self, didAdd: course)
  }

  fileprivate func handleAddCourseError(_ error: Error) {
      // Here we could check the error code and display a localized error message
      view?.displayAddCourseError(title: "Error", message: error.localizedDescription)
  }


}
