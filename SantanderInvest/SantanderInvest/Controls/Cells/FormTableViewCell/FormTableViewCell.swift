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
import InputMask

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
  var valueChanged: ((_ cell: FormTableViewCell, _ formCell:FormCell, _ value:Any?) -> Void)?
  var currentFormCell: FormCell?
  var currentControl: UIControl?
  var maskedDelegate: MaskedTextFieldDelegate!
  var isValidValue: Bool? {
    didSet {
      if let textField = currentControl as? TweeAttributedTextField {
        if let isValidValue = isValidValue {
          textField.activeLineColor = isValidValue ? Constants.colors.success : Constants.colors.error
        } else {
          textField.activeLineColor = Constants.colors.lightGray
        }
      }
    }
  }
  var value: Any? {
    didSet {
      if let currentControl = currentControl as? UITextField, let value = value as? String {
        currentControl.text = value
      } else if let currentControl = currentControl as? CheckBox, let value = value as? Bool {
        currentControl.isChecked = value
      }
    }
  }
  
  override func prepareForReuse() {
    maskedDelegate = nil
    currentControl = nil
    currentFormCell = nil
    valueChanged = nil
    maskedDelegate = nil
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
      currentControl = textField
      textField.clearButtonMode = .whileEditing
      textField.font = Constants.fonts.weight.medium.font(size: 18)
      textField.textColor = Constants.colors.almostBlack
      textField.lineColor = Constants.colors.veryLightGray
      textField.activeLineColor = Constants.colors.lightGray
      textField.placeholderColor = Constants.colors.lightGray
      textField.placeholderLabel.font = Constants.fonts.weight.regular.font(size: 16)
      textField.tweePlaceholder = formCellModel.message
      textField.delegate = self
      textField.addTarget(self, action: #selector(textFieldValueChanged), for: .valueChanged)
      
      
      if let typefield = formCellModel.typefield {
        var keyboardType = UIKeyboardType.default
        
        if typefield == .email {
          keyboardType = .emailAddress
        } else if typefield == .telNumber {
          keyboardType = .phonePad
          maskedDelegate = MaskedTextFieldDelegate(format: "([00]) [90000] [0000]")
          maskedDelegate.listener = self
          textField.delegate = maskedDelegate
        }
        
        textField.keyboardType = keyboardType
      }
      
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
      currentControl = checkBox
      checkBox.label.text = formCellModel.message
      checkBox.valueChanged = { (value) in
        if let currentFormCell = self.currentFormCell {
          self.valueChanged?(self, currentFormCell, value)
        }
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
      valueChanged?(self, currentFormCell, nil)
    }
  }
  
  @objc private func textFieldValueChanged(_ sender: UITextField) {
    if let currentFormCell = currentFormCell {
      valueChanged?(self, currentFormCell, sender.text)
    }
  }
}

extension FormTableViewCell: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

    // If masked we need the raw value
    guard maskedDelegate == nil else {
      return true
    }
    
    if let currentFormCell = currentFormCell {
      var updatedText: String?
      if let text = textField.text as NSString? {
        updatedText = text.replacingCharacters(in: range, with: string)
      }
      valueChanged?(self, currentFormCell, updatedText)
    }
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    if let currentFormCell = currentFormCell {
      textField.text = nil
      valueChanged?(self, currentFormCell, nil)
    }
    return true
  }
}

extension FormTableViewCell: MaskedTextFieldDelegateListener {
  
  open func textField(
    _ textField: UITextField,
    didFillMandatoryCharacters complete: Bool,
    didExtractValue value: String
    ) {
    if let currentFormCell = currentFormCell {
      valueChanged?(self, currentFormCell, value)
    }
  }
}
