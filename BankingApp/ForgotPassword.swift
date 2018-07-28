//
//  ForgotPassword.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/19/18.
//  Copyright © 2018 brad. All rights reserved.
//

import UIKit
import Firebase


class ForgotPassword: UIViewController {
    
    
    @IBOutlet weak var securityQuestionLabel: UILabel!
    @IBOutlet weak var securityQuestion: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var securityAnswer = "csuf"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        securityQuestionLabel.text = "What is the name of your university?"
        
        
        
    }
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {

        print("Security Answer: \(securityQuestion.text!)")
        print("Email: \(email.text!)")
        
        if(securityQuestion.text == "csuf".lowercased()) {
            
            Auth.auth().sendPasswordReset(withEmail: email.text!) { (error) in
             
                if error == nil {
                    //registration successful
                    let alertMessage = "A verification email has been sent."
                    print(alertMessage)
                    
                }else{
                    //registration failure
                    let error = error?.localizedDescription ?? String()
                    print(error)
                    
                    
                    
                }
            }
            
            
            
            
        }else {
            
            print("Security Question is incorrect...")
        }
        
    }
    
    

   
    
    
    

}//END Class
