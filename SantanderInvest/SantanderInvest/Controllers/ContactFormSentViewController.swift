//
//  ContactFormSentViewController.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 07/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import UIKit

class ContactFormSentViewController: UIViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
      navigationItem.hidesBackButton = true
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    
  @IBAction func sendNewButtonTapped(_ sender: Any) {
    self.navigationController?.pop()
  }
  
  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

}
