//
//  Transfer.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/9/18.
//  Copyright © 2018 brad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Transfer: UIViewController {
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        //populateUserData()
        updateAccountValues()
        fbActiveListner()
        
       
    }
    
   
    

    
    
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
            
            print("HUSHH")
            
            
            
              })
            
        
    }
    
  
    
    
   

}//END Class
