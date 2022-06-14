//
//  CacheCoursesProvider.swift
//  Template
//
//  Created by Oleksii Romanko on 23.05.2022.
//

import Foundation
class CacheCoursesProvider: CoursesProviderProtocol {

    let apiCoursesProvider: ApiCoursesProviderProtocol
    let storageCoursesProvider: StorageCoursesProviderProtocol

    init(apiCoursesProvider: ApiCoursesProviderProtocol, storageCoursesProvider: StorageCoursesProviderProtocol) {
        self.apiCoursesProvider = apiCoursesProvider
        self.storageCoursesProvider = storageCoursesProvider
    }

  func fetchCourses(completion: @escaping fetchCoursesCompletionHandler) {
    //1-st get locally stored
    storageCoursesProvider.fetchCourses(completion: completion)
    //2-nd make an API call
    apiCoursesProvider.fetchCourses { [weak self] result in
      self?.handleFetchCoursesApiResult( result, completion: completion)
    }
  }

  func addCourse(courseParams: AddCourseParameters, completion: @escaping addCourseCompletionHandler) {
    //1-st create online
    apiCoursesProvider.addCourse(courseParams: courseParams) { [weak self] result in
      //2-nd if ok put locally to storage or parse the answer from back and store to storage

      self?.handleAddCourseApiResult(result, completion: completion)

    }

  }


  fileprivate func handleFetchCoursesApiResult(_ result: Result<[Course]>, completion: @escaping fetchCoursesCompletionHandler) {
      switch result {
      case let .success(courses):
        storageCoursesProvider.save(courses: courses, completion: completion)

      case .failure(_):
        storageCoursesProvider.fetchCourses(completion: completion)
      }
  }

  fileprivate func handleAddCourseApiResult(_ result: Result<Course?>, completion: @escaping addCourseCompletionHandler) {
      switch result {
      case let .success(course):
        if let course = course {
        storageCoursesProvider.save(courses: [course]) { res in
          switch res {
          case let .success(courses):
            completion(.success(courses.first))
          case let .failure(err):
            completion(.failure(err))
            }
        }
        }

      case .failure(_):
        storageCoursesProvider.save(courses: []) { courses in
          completion(.failure(StorageError(message: "Can't handle storing in cache")))
        }
      }
  }



}
