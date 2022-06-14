//
//  CoursesConfigurator.swift
//  Template
//
//  Created by Oleksii Romanko on 22.05.2022.
//

import Foundation

protocol CoursesConfiguratorProtocol {
  func configure(vc: CoursesViewController)
}

class CoursesConfigurator: CoursesConfiguratorProtocol {

  func configure(vc: CoursesViewController) {
    let persistentContainer = CoreDataStack.shared.persistentContainer
    let apiClient = ApiClient(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
    let apiCoursesProvider = ApiCoursesProvider(apiClient: apiClient)
    let storageCoursesProvider = StorageCoursesProvider(persistentContainer: persistentContainer)
    let cacheCoursesProvider = CacheCoursesProvider(apiCoursesProvider: apiCoursesProvider, storageCoursesProvider: storageCoursesProvider)
    let coursesRouter = CoursesRouter(vc: vc)

    let presenter = CoursesPresenter(view: vc, dataProvider: cacheCoursesProvider, router: coursesRouter)
    vc.presenter = presenter
  }
}

