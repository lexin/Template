//
//  GETCoursesRequest.swift
//  Template
//
//  Created by Oleksii Romanko on 22.05.2022.
//

import Foundation

struct GETCoursesRequest: ApiRequestProtocol {
  var urlRequest: URLRequest {
    return ApiRequest(path: "https://api.letsbuildthatapp.com/jsondecodable/courses", networkMethod: .get).urlRequest
  }
}

