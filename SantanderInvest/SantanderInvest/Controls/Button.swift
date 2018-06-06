//
//  Button.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 06/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import UIKit

class Button: UIButton {
  
  override public var intrinsicContentSize: CGSize {
    return CGSize(width: self.frame.size.width, height: 50)
  }
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  fileprivate func setup() {
    backgroundColor = Constants.colors.defaultRed
    titleLabel?.font = Constants.fonts.weight.medium.font(size: 16)
    setTitleColor(.white, for: .normal)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.frame.size.height/2.0
  }
  
  
  // Animation
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    UIView.animate(withDuration: 0.1, animations: { () -> Void in
      self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      
    })
    super.touchesBegan(touches, with: event)
    
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    
    UIView.animate(withDuration: 0.5,
                   delay: 0,
                   usingSpringWithDamping: 0.2,
                   initialSpringVelocity: 6.0,
                   options: UIViewAnimationOptions.allowUserInteraction,
                   animations: { () -> Void in
                    self.transform = CGAffineTransform.identity
    }) { (Bool) -> Void in
      super.touchesCancelled(touches, with: event)
    }
    
  }
  
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    UIView.animate(withDuration: 0.5,
                   delay: 0,
                   usingSpringWithDamping: 0.2,
                   initialSpringVelocity: 6.0,
                   options: UIViewAnimationOptions.allowUserInteraction,
                   animations: { () -> Void in
                    self.transform = CGAffineTransform.identity
    }) { (Bool) -> Void in
      super.touchesEnded(touches, with: event)
    }
  }
}
