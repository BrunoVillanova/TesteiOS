//
//  CheckBox.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 06/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import UIKit
import SnapKit

class CheckBox: UIControl {

  let checkBox = UIView(frame: .zero)
  let label = UILabel(frame: .zero)
  var borderColor: UIColor = Constants.colors.darkDarkGray
  var fillColor: UIColor = Constants.colors.defaultRed
  var valueChanged: ((_ isChecked: Bool) -> Void)?
  var isChecked: Bool = false {
    didSet { setNeedsDisplay() }
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
  
  override func draw(_ rect: CGRect) {
    
    guard checkBox.superview != nil else {
      return
    }
    
    if isChecked {
      let padding: CGFloat = 2.0
      let fillRect = CGRect(x: checkBox.frame.origin.x+padding, y: checkBox.frame.origin.y+padding, width: checkBox.frame.size.width-(2*padding), height: checkBox.frame.size.height-(2*padding))
      let path =  UIBezierPath(roundedRect: fillRect, cornerRadius: checkBox.layer.cornerRadius/padding)
      fillColor.setFill()
      path.fill()
    }
  }

  private func setup() {
    self.backgroundColor = .clear
    
    // Checkbox
    checkBox.layer.borderColor = borderColor.cgColor
    checkBox.layer.borderWidth = 1
    checkBox.layer.cornerRadius = 3
    
    addSubview(checkBox)
    
    checkBox.snp.makeConstraints { (make) in
      make.leading.equalToSuperview()
      make.top.equalToSuperview().offset(2)
      make.height.equalTo(19)
      make.width.equalTo(19)
    }
    
    // Label
    label.font = Constants.fonts.weight.regular.font(size: 16)
    label.textColor = Constants.colors.lightGray
    label.numberOfLines = 0
    
    addSubview(label)
    
    label.snp.makeConstraints { (make) in
      make.leading.equalTo(checkBox.snp.trailing).offset(8)
      make.trailing.lessThanOrEqualToSuperview()
      make.top.equalToSuperview()
      make.bottom.lessThanOrEqualToSuperview()
    }
    
    // Tap gesture recognizer
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
    addGestureRecognizer(tapGesture)
  }
  
  // MARK: - Touch
  @objc private func handleTapGesture(recognizer: UITapGestureRecognizer) {
    isChecked = !isChecked
    valueChanged?(isChecked)
    sendActions(for: .valueChanged)
  }
}
