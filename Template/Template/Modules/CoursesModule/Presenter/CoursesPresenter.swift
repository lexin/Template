//
//  CoursesPresenter.swift
//  Template
//
//  Created by Oleksii Romanko on 22.05.2022.
//

import Foundation

protocol CoursesViewProtocol: AnyObject {
  func refreshCourses() //display courses
}

protocol CoursesPresenterProtocol: AnyObject {
  init(view: CoursesViewProtocol, dataProvider: CoursesProviderProtocol, router: CoursesRouterProtocol)
  func refresh(completion: (()->())?)
  func coursesCount() -> Int //use those kind of methods not to have an access to courses in protocol
  //or use access to courses directly
  var courses: [Course]? { get }
  func didTapOnCourse(course: Course)
}

class CoursesPresenter: CoursesPresenterProtocol {
  weak var view: CoursesViewProtocol?
  var router: CoursesRouterProtocol
  let dataProvider: CoursesProviderProtocol

  var courses: [Course]?

  required init(view: CoursesViewProtocol, dataProvider: CoursesProviderProtocol, router: CoursesRouterProtocol) {
    self.view = view
    self.dataProvider = dataProvider
    self.router = router
  }

  func refresh(completion: (()->())?) {
    dataProvider.fetchCourses { [weak self] result in
      //SORT? 
      DispatchQueue.main.async {
        switch result {
        case let .success(courses):
          self?.courses = courses.sorted(by: { c1, c2 in
            c1.name < c2.name
          })
        case let .failure(error):
          //self?.errorMessage = error.text
          printDebugLog(error.localizedDescription)

          self?.courses = []
        }
        self?.view?.refreshCourses()
        completion?()

      }
    }
  }

  func coursesCount() -> Int {
    return courses?.count ?? 0
  }

  func didTapOnCourse(course: Course) {
    router.showDetails(course: course)
  }
}
