//
//  POSTCourseRequest.swift
//  Template
//
//  Created by Oleksii Romanko on 02.06.2022.
//

import Foundation


struct POSTCourseRequest: ApiRequestProtocol {
    let addCourseParameters: AddCourseParameters

    var urlRequest: URLRequest {
      return ApiRequest(path: "https://addCourse", networkMethod: .post, headerFields: nil, body: addCourseParameters.toJsonData()).urlRequest
    }
}

extension AddCourseParameters {
    func toJsonData() -> Data {
        var dictionary = [String: Any]()
        dictionary["name"] = name
        dictionary["numberOfLessons"] = numberOfLessons
        return dictionary.toJsonData()
    }
}
