//
//  CoursesRouter.swift
//  Template
//
//  Created by Oleksii Romanko on 27.05.2022.
//

import UIKit
protocol CoursesRouterProtocol {
  func showDetails(course: Course)
}

class CoursesRouter: CoursesRouterProtocol {
  weak var vc: CoursesViewController?

  internal init(vc: CoursesViewController) {
    self.vc = vc
  }

  func showDetails(course: Course) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let detailsVC = storyboard.instantiateViewController(withIdentifier: "CourseDetailsVC") as?  CourseDetailsVC {
      detailsVC.configurator = CourseDetailsConfigurator(course: course) // ENTER POINT for Details
      vc?.navigationController?.pushViewController(detailsVC, animated: true)
    }
  }

}

