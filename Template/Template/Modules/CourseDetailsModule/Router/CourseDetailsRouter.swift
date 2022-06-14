//
//  CourseDetailsRouter.swift
//  Template
//
//  Created by Oleksii Romanko on 27.05.2022.
//

import Foundation

import UIKit
protocol CourseDetailsRouterProtocol {
  func pop()
}

class CourseDetailsRouter: CourseDetailsRouterProtocol {
  weak var vc: CourseDetailsVC?

  internal init(vc: CourseDetailsVC) {
    self.vc = vc
  }

  func pop() {
    vc?.navigationController?.popViewController(animated: true)
  }

}
