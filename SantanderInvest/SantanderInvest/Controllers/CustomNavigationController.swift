//
//  CustomNavigationController.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 30/05/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

  override var viewControllers: [UIViewController] {
    didSet {
      configureViewControllers()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

      // Do any additional setup after loading the view.
    configureNavigationBar()
    configureViewControllers()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  fileprivate func configureNavigationBar() {
    self.navigationBar.shadowImage = UIImage()
  }
  
  fileprivate func configureViewControllers() {
    viewControllers.forEach { $0.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: $0, action: nil) }
  }
}
