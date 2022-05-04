//
//  Courses.swift
//  Template
//
//  Created by Oleksii Romanko on 26.04.2022.
//

import Foundation

struct Courses: Codable, Equatable/*, CodableModel*/ {

    typealias Model = Courses

    let data: [Course]?
}

extension Courses {
    // MARK: - DecodableModel
    static func decodeModel(from data: Data) throws -> [Course] {
        let decoder = JSONDecoder()
        return try decoder.decode([Course].self, from: data)
    }

    // MARK: - EncodableModel
    static func encodeModel(_ value: Courses) throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(value)
    }
}
