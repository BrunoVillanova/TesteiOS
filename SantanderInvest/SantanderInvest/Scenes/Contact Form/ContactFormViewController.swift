//
//  ContactFormViewController.swift
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

protocol ContactFormDisplayLogic: class
{
  func displayFormCells(viewModel: ContactForm.FetchCells.ViewModel)
  func displayInvalidFormCells(viewModel: ContactForm.UpdateContactForm.ViewModel)
  func displayUpdatedFormCells(viewModel: ContactForm.UpdateContactForm.ViewModel)
  func displaySuccessSendingContactForm()
}

class ContactFormViewController: UIViewController
{
  
  @IBOutlet weak var tableView: UITableView!
  
  var interactor: ContactFormBusinessLogic?
  var router: (NSObjectProtocol & ContactFormRoutingLogic & ContactFormDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = ContactFormInteractor()
    let presenter = ContactFormPresenter()
    let router = ContactFormRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    fetchFormCells()
  }
}

// MARK: Private functions

extension ContactFormViewController {
  fileprivate func sendContactForm() {
    let request = ContactForm.SendContactForm.Request()
    interactor?.sendContactForm(request: request)
  }
  
  fileprivate func updateContactFormField(_ fieldId: Int, value: String?) {
    let contactFormFields = [ContactForm.ContactFormField(fieldId: fieldId, value: value)]
    let request = ContactForm.UpdateContactForm.Request(contactFormFields: contactFormFields)
    interactor?.updateContactForm(request: request)
  }
}

// MARK: Logic delegate

extension ContactFormViewController: ContactFormDisplayLogic {
  
  // MARK: Fetch Cells
  
  func fetchFormCells()
  {
    let request = ContactForm.FetchCells.Request()
    interactor?.fetchFormCells(request: request)
  }
  
  // MARK: Display Cells
  
  func displayFormCells(viewModel: ContactForm.FetchCells.ViewModel) {
    tableView.reloadData()
  }
  
  // MARK: Display Invalid Cells
  
  func displayInvalidFormCells(viewModel: ContactForm.UpdateContactForm.ViewModel) {
    let formCells = viewModel.formCells
    let invalidFormCellsIDs = formCells.map { $0.id! }
    tableView.visibleCells.forEach { (cell) in
      if let cell = cell as? FormTableViewCell, let formCell = cell.currentFormCell {
        if invalidFormCellsIDs.contains(formCell.id!) {
          cell.shake()
        }
      }
    }
  }
  
  // MARK: Display logic
  func displayUpdatedFormCells(viewModel: ContactForm.UpdateContactForm.ViewModel) {
    tableView.beginUpdates()
//    if let interactor = interactor, interactor.formCells.count !== viewModel.formCells.count {
//    
//    }
//    if viewModel.dataEvent.rowDeletes.count > 0 {
//      tableView.deleteRows(at: viewModel.dataEvent.rowDeletes, with: .automatic)
//    }
//    if viewModel.dataEvent.rowInserts.count > 0 {
//      tableView.insertRows(at: viewModel.dataEvent.rowInserts, with: .automatic)
//    }
//    if viewModel.dataEvent.rowUpdates.count > 0 {
//      tableView.reloadRows(at: viewModel.dataEvent.rowUpdates, with: .automatic)
//    }
//    if viewModel.dataEvent.sectionDeletes.count > 0 {
//      tableView.deleteSections(IndexSet(viewModel.dataEvent.sectionDeletes), with: .automatic)
//    }
//    if viewModel.dataEvent.sectionChanges.count > 0 {
//      tableView.reloadSections(IndexSet(viewModel.dataEvent.sectionDeletes), with: .automatic)
//    }
//    if viewModel.dataEvent.sectionInserts.count > 0 {
//      tableView.insertSections(IndexSet(viewModel.dataEvent.sectionInserts), with: .automatic)
//    }
    tableView.endUpdates()
  }
  
  // MARK: Display Form Sending Success
  
  func displaySuccessSendingContactForm() {
//    router.navigateToItemsInCategoryScene()
  }
}

// MARK: TableView data source

extension ContactFormViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let interactor = interactor {
      return interactor.formCells.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let interactor = interactor else {
      return UITableViewCell(frame: .zero)
    }
    
    let formCellObject = interactor.formCells[indexPath.row]
    let formCellStyle = FormTableViewCellStyle(rawValue: formCellObject.type!.rawValue)!
    let cellReuseIdentifier = formCellStyle.reuseIdentifier
    var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? FormTableViewCell
    
    if cell == nil {
      tableView.register(FormTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
      cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? FormTableViewCell
    }
    
    cell!.configure(formCellObject)
    cell!.valueChanged = { (cell, formCell, value) in
      
      var theValue: String? = nil
      
      if let value = value as? String {
        theValue = value
      }
      
      self.updateContactFormField(formCell.id!, value: theValue)
      
      if formCell.type == FormCellType.field, let value = value as? String? {
        var validValue: Bool?
        
        if formCell.typefield == .email {
          validValue = value?.isValidEmail
        } else if formCell.typefield == .telNumber {
          //TODO: Need API fix! Is not parsing this field correctly because API is returning "typefield": "telnumber" instead of value 2 as expected
          validValue = value?.isValidPhone
        }
        
        cell.isValidValue = validValue
      } else if formCell.type == .send {
        self.sendContactForm()
      }
    }
    
    return cell!
  }
}

// MARK: TableView delegate

extension ContactFormViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}
