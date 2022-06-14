//
//  ApiCourses.swift
//  Template
//
//  Created by Oleksii Romanko on 22.05.2022.
//

import Foundation
// This protocol in not necessarily needed since it doesn't include any extra methods
// besides what CoursesProvider already provides. However, if there would be any extra methods
// on the API that we would need to support it would make sense to have an API specific protocol
protocol ApiCoursesProviderProtocol: CoursesProviderProtocol {
}

class ApiCoursesProvider: ApiCoursesProviderProtocol {
    let apiClient: ApiClient

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

  func fetchCourses(completion: @escaping fetchCoursesCompletionHandler ) {
    let getCoursesRequest = GETCoursesRequest()
    apiClient.execute(request: getCoursesRequest) { (result: Result<ApiResponse<[ApiCourse]>>) in
        switch result {
        case let .success(response):
          let courses = response.entity.compactMap { return $0.toModel() }
          completion(.success(courses))
        case let .failure(error):
          completion(.failure(error))
        }
    }
  }

  func addCourse(courseParams: AddCourseParameters, completion: @escaping addCourseCompletionHandler) {
    let postCourseRequest = POSTCourseRequest(addCourseParameters: courseParams)
    apiClient.execute(request: postCourseRequest) { (result: Result<ApiResponse<ApiCourse>>) in
      switch result {
      case let .success(response):
        let course = response.entity.toModel()
        completion(.success(course))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
}
