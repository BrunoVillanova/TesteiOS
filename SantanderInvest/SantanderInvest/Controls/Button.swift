//
//  Button.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 06/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import UIKit

class Button: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
  
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
    setTitleColor(.white, for: .focused)
    setTitleColor(.white, for: .highlighted)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.frame.size.height/2.0
  }
}
