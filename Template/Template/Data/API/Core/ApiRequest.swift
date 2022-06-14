//
//  ApiRequest.swift
//  Template
//
//  Created by Oleksii Romanko on 02.06.2022.
//

import Foundation

struct ApiRequest: ApiRequestProtocol {

  var path: String
  var networkMethod: NetworkMethod
  var headerFields: [String: String]?
  var body: Data?

  internal init(path: String, networkMethod: NetworkMethod, headerFields: [String : String]? = nil, body: Data? = nil) {
    self.path = path
    self.networkMethod = networkMethod
    self.headerFields = headerFields
    self.body = body
  }


  var urlRequest: URLRequest {
    //"https://api.letsbuildthatapp.com/jsondecodable/courses"
    let url: URL! = URL(string: path)
    var request = URLRequest(url: url)

    //if necessary add default headerFields here
    if let headerFields = headerFields {
      for headerKey in headerFields.keys {
        request.setValue(headerFields[headerKey], forHTTPHeaderField: headerKey)
      }
    }

    request.httpMethod = networkMethod.rawValue

    return request
  }
}
