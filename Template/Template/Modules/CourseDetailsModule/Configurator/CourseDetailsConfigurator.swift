//
//  CourseDetailsConfigurator.swift
//  Template
//
//  Created by Oleksii Romanko on 27.05.2022.
//

import Foundation

protocol CourseDetailsConfiguratorProtocol {
  func configure(vc: CourseDetailsVC)
}

class CourseDetailsConfigurator: CourseDetailsConfiguratorProtocol {

  let course: Course
  init(course: Course) {
      self.course = course
  }

  func configure(vc: CourseDetailsVC) {
    let coursesRouter = CourseDetailsRouter(vc: vc)

    let persistentContainer = CoreDataStack.shared.persistentContainer
    let apiClient = ApiClient(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
    let apiCoursesProvider = ApiCoursesProvider(apiClient: apiClient)
    let storageCoursesProvider = StorageCoursesProvider(persistentContainer: persistentContainer)
    let cacheCoursesProvider = CacheCoursesProvider(apiCoursesProvider: apiCoursesProvider, storageCoursesProvider: storageCoursesProvider)
   	let presenter = CourseDetailsPresenter(view: vc, course: course, dataProvider: cacheCoursesProvider, router: coursesRouter)
    //let presenter = CourseDetailsPresenter(view: vc, course: course, dataProvider: storageCoursesProvider, router: coursesRouter)
    vc.presenter = presenter
  }
}

