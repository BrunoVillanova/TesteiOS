//
//  Constants.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 05/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
  struct fonts {
    enum weight: String {
      case regular = "DINPro-Regular",
           medium = "DINPro-Medium",
           light = "DINPro-Light"
      
      func font(size: CGFloat) -> UIFont? {
        return UIFont(name: self.rawValue, size: size)
      }
    }
  }
  struct colors {
    static let veryLightGray = UIColor(red: 239/255, green: 238/255, blue: 237/255, alpha: 1)
    static let lightGray = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
    static let darkGray = UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1)
    static let almostBlack = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    static let darkDarkGray = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
    static let defaultRed = UIColor(red: 218/255, green: 1/255, blue: 1/255, alpha: 1)
  }
}
