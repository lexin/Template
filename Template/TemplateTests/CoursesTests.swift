//
//  TemplateTests.swift
//  TemplateTests
//
//  Created by Oleksii Romanko on 02.06.2022.
//

import XCTest
@testable import Template

class MockCoursesView: CoursesViewProtocol {
  var courses: [Course]?
  var coursesToSet: [Course]!

  init() {}

  convenience init(courses: [Course]) {
    self.init()
    self.coursesToSet = courses
  }

  func refreshCourses() {
    courses = coursesToSet
  }
}

struct MockApiError: Error {
  let message: String
}

class MockCoursesProvider: CoursesProviderProtocol {
  var courses: [Course]!

  var timesFetchCoursesCalled: Int!
  init() {}

  convenience init(courses: [Course]) {
    self.init()
    timesFetchCoursesCalled = 0
    self.courses = courses
  }

  func fetchCourses(completion: @escaping fetchCoursesCompletionHandler) {
    timesFetchCoursesCalled += 1
    if let courses = self.courses {
    	completion(.success(courses))
    } else {
      completion(.failure(MockApiError(message: "ErrorMockApiProvider")))
    }
  }

  func addCourse(courseParams: AddCourseParameters, completion: @escaping addCourseCompletionHandler) {
    //do nothing
  }
}

class MockCoursesRouter: CoursesRouterProtocol {
  var detailsWereShown: Bool
  init() {
    detailsWereShown = false
  }

  func showDetails(course: Course) {
    detailsWereShown = true
  }
}


class TemplateTests: XCTestCase {

  var presenter: CoursesPresenter! //real presenter
  var viewMock: MockCoursesView!
  var providerMock: MockCoursesProvider!
  var routerMock: MockCoursesRouter!
  var coursesInput: [Course]!

  var course: Course!

    override func setUpWithError() throws {
      course = Course(id: 1, numberOfLessons: 2, name: "Foo", link: "Baz_url", imageURL: "Image_url")
      viewMock = MockCoursesView()
      providerMock = MockCoursesProvider(courses: [course])
      routerMock = MockCoursesRouter()
      presenter = CoursesPresenter(view: viewMock, dataProvider: providerMock, router: routerMock)
      coursesInput = [course]

    }

    override func tearDownWithError() throws {
      viewMock = nil
      presenter = nil
      providerMock = nil
      routerMock = nil
    }

    func testCoursesPresenter() throws {

      XCTAssertNotNil(presenter.view) // view
      XCTAssertNotNil(presenter.router) // router
      XCTAssertNotNil(presenter.dataProvider) // dataProvider

      let exp1 = expectation(description: "Refresh data")

      XCTAssertEqual(providerMock.timesFetchCoursesCalled, 0) 

      presenter.refresh { // refresh
        exp1.fulfill()
      }
      waitForExpectations(timeout: 1, handler: nil)

      XCTAssertEqual(presenter.coursesCount(), coursesInput.count) // coursesCount
      XCTAssertEqual(presenter.courses?.count, coursesInput.count) // courses

      XCTAssertEqual(providerMock.timesFetchCoursesCalled, 1) //fetch data only once

      XCTAssertFalse(routerMock.detailsWereShown)
      presenter.didTapOnCourse(course: course) // didTapOnCourse
      XCTAssertTrue(routerMock.detailsWereShown) // showDetails in router was called
    }

  func testCoursesRouter()  {

    let coursesViewController: CoursesViewController = CoursesViewController()
    let navController = MockNavigationController(rootViewController: coursesViewController)
    let router = CoursesRouter(vc: coursesViewController)

   let presenterWithRealRouter = CoursesPresenter(view: coursesViewController, dataProvider: providerMock, router: router)
    var topVC = navController.presentedVC as? CourseDetailsVC //we are sure that top VC is CourseDetailsVC

    XCTAssertNil(topVC)
    presenterWithRealRouter.didTapOnCourse(course: course)
    topVC = navController.presentedVC as? CourseDetailsVC //we are sure that top VC is CourseDetailsVC
    XCTAssertNotNil(topVC)

  }

  func testCoursesConfigurator() {
    let coursesViewController: CoursesViewController = CoursesViewController()
    let coursesConfigurator = CoursesConfigurator()

    XCTAssertNil(coursesViewController.presenter)
    coursesConfigurator.configure(vc: coursesViewController)
    XCTAssertNotNil(coursesViewController.presenter) //we are sure that CoursesConfigurator builds the presenter
  }

  func testCoursesView() {

		let viewMock = MockCoursesView(courses: coursesInput)
    let presenter = CoursesPresenter(view: viewMock, dataProvider: providerMock, router: routerMock)
    let exp1 = expectation(description: "Refresh data")
    presenter.refresh { // refresh
      exp1.fulfill()
    }
    waitForExpectations(timeout: 1, handler: nil)

    XCTAssertEqual(viewMock.courses?.count, coursesInput.count) // we are sure that refreshCourses method was called in View

  }





}
