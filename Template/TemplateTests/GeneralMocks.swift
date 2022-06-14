//
//  Mocks.swift
//  TemplateTests
//
//  Created by Oleksii Romanko on 03.06.2022.
//

import UIKit

class MockNavigationController: UINavigationController {
  var presentedVC: UIViewController?
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    self.presentedVC = viewController
    super.pushViewController(viewController, animated: animated)
  }
}

