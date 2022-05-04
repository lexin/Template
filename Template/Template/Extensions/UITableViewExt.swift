//
//  UITableViewExt.swift
//  Template
//
//  Created by Oleksii Romanko on 17.04.2022.
//

import UIKit

extension UITableView {
  enum CellIdentifier: String {
    case CourseTableViewCell
  }

  func register(_ nib: UINib, forCell cellIdentifier: CellIdentifier) {
    self.register(nib, forCellReuseIdentifier: cellIdentifier.rawValue)
  }

  func dequeueCell(_ cellIdentifier: CellIdentifier, for indexPath: IndexPath) -> UITableViewCell {
    return self.dequeueReusableCell(withIdentifier: cellIdentifier.rawValue, for: indexPath)
  }

}
