//
//  ContactFormTableViewCell.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 03/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import UIKit


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
  }
  
  func configure(_ formCellModel: FormCell) {
    //TODO: add and configure cell control view
  }
}
