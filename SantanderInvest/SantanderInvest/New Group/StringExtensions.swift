//
//  StringExtensions.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 04/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import Foundation

extension String {
  
  var isValidEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
  }
}
