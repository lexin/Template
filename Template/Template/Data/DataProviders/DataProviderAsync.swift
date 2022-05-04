//
//  DataProvider.swift
//  Template
//
//  Created by Oleksii Romanko on 17.04.2022.
//

import Foundation


protocol DataProviderAsync {
  static func fetchCourses() async -> ([Course]?, ErrorDataProviding?)
}

class LocalStorage: DataProviderAsync {
  static func fetchCourses() -> ([Course]?, ErrorDataProviding?) {
    let course = Course(id: 1, numberOfLessons: 1, name: "First", link: "", imageURL: "")
    return ([course], nil)
  }
}

class NetworkAsync: DataProviderAsync {
  static func fetchCourses() async -> ([Course]?, ErrorDataProviding?) {
    let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"

    guard let url = URL(string: urlString) else { return (nil, ErrorDataProviding(text: "wrong url")) }

    do {

        let (data, response) = try await URLSession.shared.data(from: url)
//            print(data)

        if let resp = response as? HTTPURLResponse, resp.statusCode >= 300 {
            return (nil, ErrorDataProviding(text: "Failed to hit endpoint with bad status code"))
        }

        let courses = try JSONDecoder().decode([Course].self, from: data)
        return (courses, nil)
    } catch {
        return (nil, ErrorDataProviding(text: "Failed to reach endpoing: \(error)"))
    }
}

}
