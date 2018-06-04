//
//  ContactFormInteractor.swift
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

protocol ContactFormBusinessLogic
{
  func fetchFormCells(request: ContactForm.FetchCells.Request)
}

protocol ContactFormDataStore
{
    var formCells: [FormCell]? { get }
}

class ContactFormInteractor: ContactFormBusinessLogic, ContactFormDataStore
{
  var presenter: ContactFormPresentationLogic?
  var worker: ContactFormWorker?
  var formCells: [FormCell]?
  
  
  // MARK: Fetch Cells
  
  func fetchFormCells(request: ContactForm.FetchCells.Request)
  {
    worker = ContactFormWorker()
    worker?.fetchContactFormCells { (formCells, error) -> Void in
        self.formCells = formCells
      let response = ContactForm.FetchCells.Response(cells: formCells, error: error)
        self.presenter?.presentContactForm(response: response)
    }
  }
}
