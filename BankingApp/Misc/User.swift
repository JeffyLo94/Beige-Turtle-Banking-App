//
//  User.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/9/18.
//  Copyright © 2018 brad. All rights reserved.
//

import Foundation

var dataArray = [account]()

struct client {
    
    static var name: String!
    static var email: String!
    static var phone: String!
    static var number_of_accounts: Int!

}

struct account {
    
    
    var name: String!
    var balance: Double!
    var amount_due: Double!
    var available_balance: Double!
    var credit_limit: Double!
    
}

//struct accountGlobal {
//
//
//    let name: String!
//    let balance: Double!
//    let amount_due: Double!
//    let available_balance: Double!
//    let credit_limit: Double!
//
//}


struct checking {
    
    static var name: String!
    static var balance: Double!
    static var available_balance: Double!
    
}

struct savings {
    
    static var name: String!
    static var balance: Double!
    static var available_balance: Double!
    
}

struct credit {
    
    static var name: String!
    static var balance: Double!
    static var credit_limit: Double!
}



//For populating user data in database

//
//ref.child("accounts").child(userID).child("checking").setValue(["account_name": "Checking",
//                                                                "account_balance": 536454.23,
//                                                                "available_balance": 536454.23,
//                                                                "amount_due": 0,
//                                                                "credit_limit": 0,
//                                                                ])
//
//ref.child("accounts").child(userID).child("savings").setValue(["account_name": "Savings",
//                                                               "account_balance": 300432.27,
//                                                               "available_balance": 300432.27,
//                                                               "amount_due": 0,
//                                                               "credit_limit": 0,
//                                                               ])
//
//
//ref.child("accounts").child(userID).child("credit").setValue(["account_name": "Credit Visa",
//                                                              "account_balance": 500000.00,
//                                                              "available_balance": 300000.00,
//                                                              "amount_due": 67323.12,
//                                                              "credit_limit": 500000.00,
//                                                              ])
//
//func populateUserData() {//Delete Later
//
//    let userID : String = Auth.auth().currentUser!.uid
//    ref = Database.database().reference()
//
//    ref.child("users").child(userID).setValue(["name": "John Doe",
//                                               "email": "johndoe@gmail.com",
//                                               "phone": "9494234088",
//                                               ])
//
//}
