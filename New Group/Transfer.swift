//
//  Transfer.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/9/18.
//  Copyright © 2018 brad. All rights reserved.
//

//Example of picker view
//https://codewithchris.com/uipickerview-example/

import UIKit
import Firebase
import FirebaseDatabase

class Transfer: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var amount_Transfer: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        updateAccountValues()
//        fbActiveListner()
        hideKeyboardWhenTappedAround()
        
       
    }
    
   
    
    @IBAction func TransferB(_ sender: Any) {
        
        print("Button Pressed")
        print("Transfer Amount: \(amount_Transfer.text!)")
        print("$ Amount: \(String(describing: Double(amount_Transfer.text!)!.currency))")
        
        //Acount for button amount_Transfer == nil
        //Logic of saving and checkings transfer
        
        //if transfer_amount <= FROM ACCOUNT
        //..........transfer funds
        //else
        //error not enough funds in FROM ACCOUNT
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Functions Below are for Firebase Database
    
    
    func updateAccountValues() {
        
        let userID : String = Auth.auth().currentUser!.uid
        ref = Database.database().reference()
        
        ref.child("accounts").child(userID).child("checking").updateChildValues(["account_balance": checking.balance,
                                                                        "available_balance": checking.available_balance,
                                                                        ])
        ref.child("accounts").child(userID).child("savings").updateChildValues(["account_balance": savings.balance,
                                                                                 "available_balance": savings.balance,
                                                                                 ])
        
        //adds transaction to "ransactions" in database
        //ref.child("transactions").child(userID).childByAutoId().setValue(["transaction": "0.00"])
    }
    
    
    
    
    
    func fbActiveListner() {
        
        let userID : String = Auth.auth().currentUser!.uid
        ref = Database.database().reference()
        
        ref.child("transactions").child(userID).queryOrderedByKey().observe(.childAdded, with: {snapshot in
            
          print("Something was changed...")
            
//            let snapDict = snapshot.value as? NSDictionary
//            let balance = snapDict?["account_balance"] as! Double
            
            //insert or append in array with struct
  
            
            
            
              })
            
        
    }
    
  
    
    
   

}//END Class