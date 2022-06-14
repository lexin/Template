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
  struct PresentingModel {
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

  func setData(model: PresentingModel) {
    courseTitleLabel.text = model.title
    courseImageView.sd_setImage(with: model.imageUrl)
  }


}
