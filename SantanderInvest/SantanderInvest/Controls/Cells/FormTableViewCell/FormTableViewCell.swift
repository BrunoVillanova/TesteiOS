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
  var valueChanged: ((_ formCell:FormCell, _ value:Any?) -> Void)?
  var currentFormCell: FormCell?
  
  override func prepareForReuse() {
    currentFormCell = nil
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
    
    currentFormCell = formCellModel
    let contentView = self.contentView
    let controlContainer = UIView()
    contentView.addSubview(controlContainer)
    
    controlContainer.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.centerX.equalToSuperview()
      make.width.equalTo(315)
    }
    
    if formCellModel.type == .field {
      let textField = TweeAttributedTextField(frame: .zero)
      textField.clearButtonMode = .whileEditing
      textField.font = Constants.fonts.weight.medium.font(size: 18)
      textField.textColor = Constants.colors.almostBlack
      textField.lineColor = Constants.colors.veryLightGray
      textField.activeLineColor = Constants.colors.lightGray
      textField.placeholderColor = Constants.colors.lightGray
      textField.placeholderLabel.font = Constants.fonts.weight.regular.font(size: 16)
      textField.tweePlaceholder = formCellModel.message
      
      let topSpacing: CGFloat = (formCellModel.topSpacing != nil) ? (CGFloat(formCellModel.topSpacing!) + 16.0) : 16.0
      
      controlContainer.addSubview(textField)
      textField.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(topSpacing)
        make.leading.equalToSuperview().offset(20)
        make.trailing.equalToSuperview().offset(-20)
        make.bottom.equalToSuperview()
        make.height.equalTo(47)
      }
    } else if formCellModel.type == .text {
      let textLabel = UILabel(frame: .zero)
      textLabel.font = Constants.fonts.weight.light.font(size: 16)
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
    } else if formCellModel.type == .checkbox {
      let checkBox = CheckBox(frame: .zero)
      checkBox.label.text = formCellModel.message
      checkBox.valueChanged = { (value) in
        print("\(String(describing: formCellModel.message))? \(value)")
      }
      
      let topSpacing: CGFloat = (formCellModel.topSpacing != nil) ? CGFloat(formCellModel.topSpacing!) : 0.00
      
      controlContainer.addSubview(checkBox)
      checkBox.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(topSpacing)
        make.leading.equalToSuperview().offset(20)
        make.trailing.equalToSuperview().offset(-20)
        make.bottom.equalToSuperview()
      }
    } else if formCellModel.type == .send {
      let button = Button(frame: .zero)
      button.setTitle(formCellModel.message, for: .normal)
      button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
      
      let topSpacing: CGFloat = (formCellModel.topSpacing != nil) ? CGFloat(formCellModel.topSpacing!) : 0.00
      
      controlContainer.addSubview(button)
      button.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(topSpacing)
        make.leading.equalToSuperview()
        make.trailing.equalToSuperview()
        make.bottom.equalToSuperview()
      }
    }
  }
  
  @objc private func buttonTapped(_ sender: Button) {
    if let currentFormCell = currentFormCell {
      valueChanged?(currentFormCell, nil)
    }
  }
}
