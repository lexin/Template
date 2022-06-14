//
//  CourseDetailsVC.swift
//  Template
//
//  Created by Oleksii Romanko on 27.05.2022.
//


import UIKit
class CourseDetailsVC: UIViewController {
  @IBOutlet private var titleLabel: UILabel!

  var presenter: CourseDetailsPresenterProtocol!
  var configurator: CourseDetailsConfiguratorProtocol!

  override func viewDidLoad() {
      super.viewDidLoad()

      configurator.configure(vc: self)
      presenter.showCourse()

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in 
      //self?.presenter.didTapBack()
      self?.presenter.saveCourse(courseParams: AddCourseParameters(name: "New course", numberOfLessons: 1))
    }

  }

}

extension CourseDetailsVC: CourseDetailsViewProtocol {
  func showCourse(course: Course) {
    titleLabel.text = course.name
  }

  func displayAddCourseError(title: String, message: String) {
    titleLabel.text = title + " " + message
  }


}
