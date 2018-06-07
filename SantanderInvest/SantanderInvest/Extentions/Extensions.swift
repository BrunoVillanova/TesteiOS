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
  
  var isValidPhone: Bool {
    //TODO: Implement phone validation
//    ^(\(11\) [9][0-9]{4}-[0-9]{4})|(\(1[2-9]\) [5-9][0-9]{3}-[0-9]{4})|(\([2-9][1-9]\) [5-9][0-9]{3}-[0-9]{4})$
    return true
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

extension UIView {
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = 0.6
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    layer.add(animation, forKey: "shake")
  }
}

///
/// Navigation Controller Fade In/Out Transition
/// Credits to Luca Davanzo on StackOverflow: https://stackoverflow.com/questions/2215672/how-to-change-the-push-and-pop-animations-in-a-navigation-based-app
///
extension UINavigationController {
  
  /**
   Pop current view controller to previous view controller.
   
   - parameter type:     transition animation type.
   - parameter duration: transition animation duration.
   */
  func pop(transitionType type: String = kCATransitionFade, duration: CFTimeInterval = 0.3) {
    self.addTransition(transitionType: type, duration: duration)
    self.popViewController(animated: false)
  }
  
  /**
   Push a new view controller on the view controllers's stack.
   
   - parameter vc:       view controller to push.
   - parameter type:     transition animation type.
   - parameter duration: transition animation duration.
   */
  func push(viewController vc: UIViewController, transitionType type: String = kCATransitionFade, duration: CFTimeInterval = 0.3) {
    self.addTransition(transitionType: type, duration: duration)
    self.pushViewController(vc, animated: false)
  }
  
  func addTransition(transitionType type: String = kCATransitionFade, duration: CFTimeInterval = 0.3) {
    let transition = CATransition()
    transition.duration = duration
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.type = type
    self.view.layer.add(transition, forKey: nil)
  }
  
}
