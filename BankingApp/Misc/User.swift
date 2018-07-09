//
//  User.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/9/18.
//  Copyright © 2018 brad. All rights reserved.
//

import Foundation



struct client {
    
    static var name: String!
    static var email: String!
    static var phone: String!
    static var saving: Double!
    static var checking: Double!
    
   
}




//For populating user data in database


//func populateUserData() {//Delete Later
//
//    let userID : String = Auth.auth().currentUser!.uid
//    ref = Database.database().reference()
//
//    ref.child("users").child(userID).setValue(["name": "john Doe",
//                                               "email": "johndoe@gmail.com",
//                                               "savings": 536454.23,
//                                               "checking": 323492.27,
//                                               "phone": "9494234088",
//                                               ])
//
//}
