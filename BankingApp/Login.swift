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
        
        hideKeyboardWhenTappedAround()
        
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        print("Login Button Pressed...\n")
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error == nil {
                //Registration Successfull
                print("Login Successfull...\n")
                print("User Logged In: \(String(describing: user!.user.uid))\n")
                
                
                let userID = Auth.auth().currentUser?.uid
                let ref = Database.database().reference()
                
                
                
                ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    
                    let snapDict = snapshot.value as? NSDictionary
                    client.name = snapDict?["name"] as? String ?? ""
                    client.phone = snapDict?["phone"] as? String ?? ""
                    client.email = snapDict?["email"] as? String ?? ""
                   
                    
                    //self.performSegue(withIdentifier: "goMain", sender: nil)
                    
                })
                
                ref.child("accounts").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    
                    client.number_of_accounts = Int(snapshot.childrenCount)
                    
                    for child in snapshot.children.allObjects as! [DataSnapshot] {
                        //print(child.value)
                        let dict = child.value as? [String : AnyObject] ?? [:]
//                        print(dict["account_balance"])
                        
                        guard let acctType = dict["account_type"] else {
//                            account.name = "ERROR - Uknown Acct Type"
                            print("WARNING - Account Type Missing\nNot added to accounts list")
                            continue
                        }
                        var acct = account(name: "", balance: 0.0, amount_due: 0.0, available_balance: 0.0, credit_limit: 0.0)
                        
                        acct.name = String(describing: acctType)
                        acct.balance = dict["account_balance"] as! Double
                        acct.available_balance = dict["available_balance"] as! Double
                        
                        if(acct.name == "Visa Credit"){
                            
                            acct.name = dict["account_type"] as! String
                            acct.balance = dict["account_balance"] as! Double
                            acct.available_balance = dict["account_balance"] as! Double
                            acct.amount_due = dict["amount_due"] as! Double
                            acct.credit_limit = dict["credit_limit"] as! Double
                            
                            
                        }
                        
                        
                        dataArray.append(acct)
                        
                    }
                    
                    
                    
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

