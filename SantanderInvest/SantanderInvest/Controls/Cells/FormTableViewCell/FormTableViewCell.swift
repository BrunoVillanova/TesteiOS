//
//  ContactFormTableViewCell.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 03/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import UIKit
import SnapKit
import TweeTextField

enum FormTableViewCellStyle: Int {
  case field = 1,
      text = 2,
      image = 3,
      checkbox = 4,
      send = 5
  
  var reuseIdentifier: String {
    switch self {
      case .field: return "field"
      case .text: return "text"
      case .image: return "image"
      case .checkbox: return "checkbox"
      case .send: return "send"
    }
  }
}

class FormTableViewCell: UITableViewCell {
  
  var cellStyle: FormTableViewCellStyle?
  
  override func prepareForReuse() {
    contentView.subviews.forEach { $0.removeFromSuperview() }
  }
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }
  
  convenience init(style: FormTableViewCellStyle) {
    self.init(style: .default, reuseIdentifier: style.reuseIdentifier)
    cellStyle = style
  }
  
  func configure(_ formCellModel: FormCell) {
    
    let contentView = self.contentView
    let controlContainer = UIView()
//    controlContainer.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(controlContainer)
    
    controlContainer.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.centerX.equalToSuperview()
      make.width.equalTo(295)
    }
    
    if formCellModel.type == .field {
      let textField = TweeAttributedTextField(frame: .zero)
//      textField.infoLabel.font = UIFont(name: "DINPro-Regular", size: 16)
//      textField.infoLabel.textColor = Constants.colors.lightGray
//      textField.infoTextColor = Constants.colors.lightGray
      textField.clearButtonMode = .whileEditing
      textField.font = UIFont(name: "DINPro-Medium", size: 18)
      textField.textColor = Constants.colors.almostBlack
      textField.lineColor = Constants.colors.veryLightGray
      textField.activeLineColor = Constants.colors.lightGray
      textField.placeholderColor = Constants.colors.lightGray
      textField.placeholderLabel.font = UIFont(name: "DINPro-Regular", size: 16)
      textField.tweePlaceholder = formCellModel.message
      
      let topSpacing: CGFloat = (formCellModel.topSpacing != nil) ? (CGFloat(formCellModel.topSpacing!) + 16.0) : 16.0
      
      controlContainer.addSubview(textField)
      textField.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(topSpacing)
        make.leading.equalToSuperview()
        make.trailing.equalToSuperview()
        make.bottom.equalToSuperview()
        make.height.equalTo(47)
      }
    } else if formCellModel.type == .text {
      let textLabel = UILabel(frame: .zero)
      textLabel.font = UIFont(name: "DINPro-Light", size: 16)
      textLabel.textColor = Constants.colors.darkGray
      textLabel.numberOfLines = 0
      textLabel.text = formCellModel.message
      
      let topSpacing: CGFloat = (formCellModel.topSpacing != nil) ? CGFloat(formCellModel.topSpacing!) : 0.00
      
      controlContainer.addSubview(textLabel)
      textLabel.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(topSpacing)
        make.leading.equalToSuperview()
        make.trailing.equalToSuperview()
        make.bottom.equalToSuperview()
      }
    }
  }
}
