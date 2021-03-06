//
//  ContactFormWorker.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 29/05/18.
//  Copyright (c) 2018 Santander. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ContactFormWorker
{
  func fetchContactFormCells(completionHandler: @escaping ([FormCell]?, Error?) -> Void)
  {
    
    Alamofire.request("https://floating-mountain-50292.herokuapp.com/cells.json").responseObject { (response: DataResponse<CellsResponse>) in
      if let error = response.error {
        completionHandler(nil, error);
      } else if let cellsResponse = response.result.value, let formCells = cellsResponse.cells {
        completionHandler(formCells, nil)
      } else {
        completionHandler([], nil)
      }
    }
  }
}
