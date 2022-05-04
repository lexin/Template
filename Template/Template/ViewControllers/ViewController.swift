//
//  ViewController.swift
//  Template
//
//  Created by Alexey Romanko on 17.04.2022.
//

import UIKit
import Combine

class ContentViewModel: ObservableObject {

  @Published var isFetching = false
  @Published var courses = [Course]()

  @Published var errorMessage = ""

  init() {
  }

  func fetchDataAsync() async {
    isFetching = true
    let (courses, error) = await NetworkAsync.fetchCourses()
    //let (courses, error) = await LocalStorage.fetchCourses()
    if let error = error {
      self.errorMessage = error.text
    }
    self.courses = courses ?? []
    isFetching = false
  }

  func fetchData(completion: ((_ success: Bool)->())?) {
    isFetching = true
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let syncContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //Network(persistentContainer: persistentContainer, syncContext: syncContext).fetchCourses { [weak self] courses, error in
    CoreDataStorage(syncContext: syncContext).fetchCourses { [weak self] courses, error in
      self?.isFetching = false
      if let error = error {
        self?.errorMessage = error.text
        self?.courses = []
        completion?(false)
      } else {
      	self?.courses = courses ?? []
        completion?(true)
      }
    }
  }

}

class ViewController: UIViewController {
  @IBOutlet private var table: UITableView!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!
  var subscriptions = [AnyCancellable]()
  private var viewModel : ContentViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()

    table.register(UINib.nib(.CourseTableViewCell), forCell: .CourseTableViewCell)

    viewModel = ContentViewModel()

//    viewModel?.$courses
//      .sink(receiveValue: { [weak self] courses in
//        DispatchQueue.main.async {
//        	self?.table.reloadData()
//        }
//      }).store(in: &subscriptions)

    viewModel?.$isFetching
      .sink(receiveValue: { [weak self] isFetching in
        DispatchQueue.main.async {
          if isFetching {
          	self?.activityIndicator.startAnimating()
          } else {
            self?.activityIndicator.stopAnimating()
          }
        }
      }).store(in: &subscriptions)


//    Task {
//    	await viewModel?.fetchDataAsync()
//    }
    viewModel?.fetchData(completion: { [weak self]  success in
      DispatchQueue.main.async {
        self?.table.reloadData()
      }
    })
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.courses.count ?? 0
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueCell(.CourseTableViewCell, for: indexPath) as! CourseTableViewCell
    if let course = viewModel?.courses[indexPath.row] {
      let viewModelForCell = CourseTableViewCell.ViewModel(title: course.name, imageUrl: URL(string: course.imageURL))
      		cell.setData(viewModel: viewModelForCell)
    }


    return cell
  }
}

