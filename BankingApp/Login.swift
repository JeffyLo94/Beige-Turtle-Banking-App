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
                            print("WARNING - Account Type Missing/nNot added to accounts list")
                            continue
                        }
                        
                        account.name = String(describing: acctType)
                        account.balance = dict["account_balance"] as! Double
                        account.available_balance = dict["available_balance"] as! Double
                        
                        if(account.name == "Visa Credit"){
                            
                            account.name = dict["account_type"] as! String
                            account.balance = dict["account_balance"] as! Double
                            account.available_balance = dict["account_balance"] as! Double
                            account.amount_due = dict["amount_due"] as! Double
                            account.credit_limit = dict["credit_limit"] as! Double
                            
                            
                        }
                        
                        
                        dataArray.append(accountGlobal(name: account.name,  balance: account.balance, amount_due: account.amount_due, available_balance: account.available_balance, credit_limit: account.credit_limit))
                        
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

