//
//  ProfileViewController.swift
//  CheckIn
//
//  Created by Anand Kelkar on 04/12/18.
//  Copyright © 2018 Anand Kelkar. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {
    
    
    @IBOutlet var numberInPartyTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet var checkInLabel: UILabel!
    @IBAction func dismissProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var fname = ""
    var lname = ""
    var sname = ""
    var id = ""
    
    override func viewDidLoad() {
        // idLabel.text = id
        checkInLabel.text = "Check In \(fname) \(lname)"
        navigationController?.setNavigationBarHidden(false, animated: true)
        preferredContentSize = CGSize(width: view.frame.width/2, height: view.frame.height/2)
        numberInPartyTextField.text = "3"
        numberInPartyTextField.textAlignment = .center
    }
}
