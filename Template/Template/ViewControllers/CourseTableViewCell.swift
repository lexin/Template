//
//  CourseTableViewCell.swift
//  Template
//
//  Created by Oleksii Romanko on 17.04.2022.
//

import Foundation
import UIKit
import SDWebImage

class CourseTableViewCell: UITableViewCell {
  struct ViewModel {
    let title: String
    let imageUrl: URL?
  }

  @IBOutlet var courseTitleLabel: UILabel!
  @IBOutlet var courseImageView: UIImageView!


  override func prepareForReuse() {
    super.prepareForReuse()
    courseTitleLabel.text = ""
    courseImageView.image = nil
  }

  func setData(viewModel: ViewModel) {
    courseTitleLabel.text = viewModel.title
    courseImageView.sd_setImage(with: viewModel.imageUrl)
  }


}
