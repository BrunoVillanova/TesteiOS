//
//  ContactFormPresenter.swift
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

protocol ContactFormPresentationLogic
{
  func presentContactForm(response: ContactForm.FetchCells.Response)
}

class ContactFormPresenter: ContactFormPresentationLogic
{
  weak var viewController: ContactFormDisplayLogic?
  
  func presentContactForm(response: ContactForm.FetchCells.Response)
  {
    
    var contactFormCells: [FormCell] = []
    
    if let formCells = response.cells {
      contactFormCells = formCells
    }
    
    let viewModel = ContactForm.FetchCells.ViewModel(formCells: contactFormCells)
    viewController?.displayFormCells(viewModel: viewModel)
  }
}