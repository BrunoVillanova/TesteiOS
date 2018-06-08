//
//  FormCell.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 03/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import Foundation
import ObjectMapper

enum FormCellType: Int {
  case field = 1,
       text = 2,
       image = 3,
       checkbox = 4,
       send = 5
  
  var editable: Bool {
    switch self {
    case .field, .checkbox:
      return true
    default:
      return false
    }
  }
}

enum FieldType: Int {
  case text = 1,
       telNumber = 2,
       email = 3
}

struct CellsResponse: Mappable {
  var cells: [FormCell]?
  
  init?(map: Map) {}
  
  mutating func mapping(map: Map) {
    cells <- map["cells"]
  }
}

struct FormCell: Mappable {
  
  var id: Int?
  var type: FormCellType?
  var message: String?
  var typefield: FieldType?
  var hidden: Bool?
  var topSpacing: Float?
  var show: Int?
  var required: Bool?
  var editable: Bool {
    get {
      if let type = self.type {
        return type.editable
      }
      return false
    }
  }
  
  init?(map: Map) {}
  
  mutating func mapping(map: Map) {
    id <- map["id"]
    type <- map["type"]
    message <- map["message"]
    typefield <- (map["typefield"], FieldTypeTransform())
    hidden <- map["hidden"]
    topSpacing <- map["topSpacing"]
    show <- map["show"]
    required <- map["required"]
  }
}

class FieldTypeTransform: TransformType {
  
  public typealias Object = FieldType
  public typealias JSON = [[String:Any]]
  
  func transformToJSON(_ value: FieldType?) -> [[String : Any]]? {
    return nil
  }
  
  // This is a fix to API bug returning string instead of int in field type
  func transformFromJSON(_ value: Any?) -> FieldType? {
    if let fieldType = value as? Int {
      return FieldType(rawValue: fieldType)
    } else if let fieldType = value as? String {
      if fieldType == "telnumber" {
        return FieldType.telNumber
      }
    }
    return nil
  }
}

