//
//  UINibExt.swift
//  Template
//
//  Created by Oleksii Romanko on 17.04.2022.
//

import UIKit
extension UINib {
  enum Name: String {
    case CourseTableViewCell
  }

  class func nib(_ name: Name, inBundle bundle: Bundle? = nil) -> UINib {
    return UINib(nibName: name.rawValue, bundle: bundle)
  }
}
