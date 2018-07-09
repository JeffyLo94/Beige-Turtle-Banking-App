//
//  ViewController.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/3/18.
//  Copyright © 2018 brad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Login: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        print("Login Button Pressed...")
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error == nil {
                //Registration Successfull
                print("Login Successfull...")
                print("User Logged In: \(String(describing: user!.user.uid))")
                
                
                let userID = Auth.auth().currentUser?.uid
                let ref = Database.database().reference()
                
                
                
                ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    
                    let snapDict = snapshot.value as? NSDictionary
                    client.name = snapDict?["name"] as? String ?? ""
                    client.phone = snapDict?["phone"] as? String ?? ""
                    client.email = snapDict?["email"] as? String ?? ""
                    client.checking = snapDict?["checking"] as! Double
                    client.saving = snapDict?["savings"] as! Double
                   
                    
                    self.performSegue(withIdentifier: "goMain", sender: nil)
                    
                })
                
                
                
            }else{
                //Registration failure
                print(error?.localizedDescription ?? String())
                print("Unsuccessful login...")
                Alerts().invalidLogin(sender: self)
            }
            
        }
        
    }//END loginButtonTapped()
    
  
}

