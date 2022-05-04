//
//  DataProviderOld.swift
//  Template
//
//  Created by Oleksii Romanko on 17.04.2022.
//

import Foundation
import UIKit

struct ErrorDataProviding {
  let text: String
}

protocol DataProvider {
  func fetchCourses(completion: @escaping ([Course]?, ErrorDataProviding?) -> () )
}


