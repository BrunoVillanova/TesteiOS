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
  var formCells: [FormCell] { get }
  func fetchFormCells(request: ContactForm.FetchCells.Request)
  func sendContactForm(request: ContactForm.SendContactForm.Request)
  func updateContactForm(request: ContactForm.UpdateContactForm.Request)
}

protocol ContactFormDataStore
{
   var formCells: [FormCell] { get }
}

class ContactFormInteractor: ContactFormBusinessLogic, ContactFormDataStore
{
  var presenter: ContactFormPresentationLogic?
  var worker: ContactFormWorker?
  var formCells = [FormCell]()
  var contactFormFields = [ContactForm.ContactFormField]()
  
  // MARK: Fetch Cells
  
  func fetchFormCells(request: ContactForm.FetchCells.Request)
  {
    worker = ContactFormWorker()
    worker?.fetchContactFormCells { (formCells, error) -> Void in
      self.formCells = formCells!
      let response = ContactForm.FetchCells.Response(cells: formCells, error: error)
      self.presenter?.presentContactForm(response: response)
    }
  }
  
  func validateContactForm(contactFormFields: [ContactForm.ContactFormField]) -> Bool {
    let requiredFields = formCells.filter { $0.required == true }
    let requiredEditableFields = requiredFields.filter { $0.editable == true }
    let requiredEditableFieldsIDs = Set(requiredEditableFields.map { $0.id! })
    let contactFormFieldsIDs = Set(contactFormFields.map { $0.fieldId })
    
    let foundRequiredFieldsIDs = contactFormFieldsIDs.intersection(requiredEditableFieldsIDs)
    let notFoundRequiredFieldsIDs = requiredEditableFieldsIDs.subtracting(foundRequiredFieldsIDs)
    var invalidFieldsIDs = notFoundRequiredFieldsIDs
    
    for foundRequiredFieldID in foundRequiredFieldsIDs {
      let foundRequiredField = formCells.first { $0.id == foundRequiredFieldID }
      
      if let typeField = foundRequiredField?.typefield {
        
        var isValid = false
        
        if let theField = contactFormFields.first(where: { (cf) -> Bool in
          return cf.fieldId == foundRequiredFieldID
        }), let theValue = theField.value {
          if typeField == .email {
            isValid = theValue.isValidEmail
          } else if typeField == .telNumber {
            isValid = theValue.isValidPhone
          } else if typeField == .text {
            isValid = theValue.count > 3
          }
        }

        if !isValid {
          invalidFieldsIDs.insert(foundRequiredFieldID)
        }
      }
    }
    
    let invalidFormCells = formCells.filter({ (ifc) -> Bool in
      return invalidFieldsIDs.contains(ifc.id!)
    })
    
    let response = ContactForm.UpdateContactForm.Response(cells: invalidFormCells)
    self.presenter?.presentInvalidFormCells(response: response)
    
    return (invalidFormCells.count == 0)
  }
  
  
  func sendContactForm(request: ContactForm.SendContactForm.Request)
  {
    // TODO: send the populated ContactFormFields and show success
    if validateContactForm(contactFormFields: self.contactFormFields) {
      self.presenter?.presentSuccessSendingContactForm()
    }
  }
  
  func updateContactForm(request: ContactForm.UpdateContactForm.Request) {
    
    for contactFormField in request.contactFormFields {
      let existingFieldIndex = contactFormFields.index {$0.fieldId == contactFormField.fieldId  }
      if existingFieldIndex != nil {
        contactFormFields.remove(at: existingFieldIndex!)
      }
      
      contactFormFields.append(contactFormField)
    }
  }
}
