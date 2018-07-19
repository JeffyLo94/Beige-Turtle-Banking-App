//
//  ForgotPassword.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/19/18.
//  Copyright © 2018 brad. All rights reserved.
//

import UIKit

class ForgotPassword: UIViewController {
    
    
    @IBOutlet weak var securityQuestionLabel: UILabel!
    @IBOutlet weak var securityQuestion: UITextField!
    @IBOutlet weak var email: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {

        print("Security Answer: \(securityQuestion.text!)")
        print("Email: \(email.text!)")
        
    }
    
    

   
    
    
    

}//END Class
