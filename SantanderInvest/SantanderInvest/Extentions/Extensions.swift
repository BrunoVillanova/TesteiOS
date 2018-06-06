//
//  StringExtensions.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 04/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import Foundation
import UIKit

extension String {
  
  var isValidEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
  }
}

extension UIColor {
  func image(size: CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    self.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }
}
