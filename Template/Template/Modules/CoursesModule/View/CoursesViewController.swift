//
//  ViewController.swift
//  Template
//
//  Created by Alexey Romanko on 17.04.2022.
//

import UIKit

class CoursesViewController: UIViewController {
  @IBOutlet private var table: UITableView!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!
  var configurator = CoursesConfigurator()
  var presenter: CoursesPresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()
    table.register(UINib.nib(.CourseTableViewCell), forCell: .CourseTableViewCell)
    configurator.configure(vc: self) // ENTER POINT
    presenter.refresh(completion: nil)

    //    viewModel?.$isFetching
    //      .sink(receiveValue: { [weak self] isFetching in
    //        DispatchQueue.main.async {
    //          if isFetching {
    //          	self?.activityIndicator.startAnimating()
    //          } else {
    //            self?.activityIndicator.stopAnimating()
    //          }
    //        }
    //      }).store(in: &subscriptions)


  }
}

extension CoursesViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.coursesCount()
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueCell(.CourseTableViewCell, for: indexPath) as! CourseTableViewCell
    if let course = presenter.courses?[indexPath.row] {
      let presentingModelForCell = CourseTableViewCell.PresentingModel(title: course.name, imageUrl: URL(string: course.imageURL))
      cell.setData(model: presentingModelForCell)
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let course = presenter.courses?[indexPath.row] {
      presenter.didTapOnCourse(course: course)
    }
  }
}

extension CoursesViewController: CoursesViewProtocol {
  func refreshCourses() {
    table.reloadData()
  }


}

