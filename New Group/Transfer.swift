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

class Transfer: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var transferFromPicker: UIPickerView!
    @IBOutlet weak var transferToPicker: UIPickerView!
    @IBOutlet weak var amountEntered: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    //Remeber names of account
    var toAccount: Int = 0
    var fromAccount: Int = 0
    var logMsg: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transferFromPicker.dataSource = self
        self.transferFromPicker.delegate = self
        
        self.transferToPicker.dataSource = self
        self.transferToPicker.delegate = self
        
        //        updateAccountValues()
        //        fbActiveListner()
        hideKeyboardWhenTappedAround()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return client.number_of_accounts
        if pickerView == transferFromPicker
        {
            return dataArray.count-1
        }
        else
        {
            return dataArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView == transferFromPicker)
        {
            fromAccount = row
        }
        else{
            toAccount = row
        }
    }
    
    @IBAction func transferButton(_ sender: UIButton) {
        //Checks if user selected the same accounts
        //Should display an Alert Message But I dont know how
        
        
        if toAccount == fromAccount{
            print("Accounts cannot be the same")
            errorLabel.text = "* Accounts cannot be the same"
        }
            // else if Int(amountEntered.text!) > dataArray[fromAccount].available_balance
        else{
            // Coverts textfield into an Int
            let TranAmount: Double! = Double(amountEntered.text!)
            // Retrieve available ballace of fromAccount
            let curAmount: Double = Double(dataArray[fromAccount].available_balance)
            //let accountName = dataArray[fromAccount].name
            
            
            
            // Check if amount wanting to be transfer exceeds available balance
            if TranAmount == nil
            {
                print("No amount entered")
                errorLabel.text = "* Enter amount over $0.0"
            }
            else if TranAmount > curAmount
            {
                print("Not enough funds")
                errorLabel.text = "* Not enough funds"
            }
            else if TranAmount < 0
            {
                print("Must transfer over $0.0")
                errorLabel.text = "* Must transfer over $0.0"
            }
            else
            {
                print("checking")
                if fromAccount == 0
                {
                    // SUBTRACT from checking
                    checking.available_balance = checking.available_balance - TranAmount
                    checking.balance = checking.balance - TranAmount
                    
                    // Update values in database
                    dataArray[0].available_balance = checking.available_balance
                    dataArray[0].balance = checking.balance
                    
                    // ADD to savings
                    if toAccount == 1 {
                        savings.available_balance = savings.available_balance + TranAmount
                        savings.balance = savings.balance + TranAmount
                        print("Transfered from Checkings to Savings")
                        errorLabel.text = ""
                        Alerts().validTransfer(sender: self)
                        
                        // Update database
                        dataArray[1].available_balance = savings.available_balance
                        dataArray[1].balance = savings.balance
                        
                        logMsg = "Checking transfer + \(String(savings.balance.currency))"
                        print(logMsg)
                    }
                    else {
                        if credit.balance + TranAmount < credit.credit_limit
                        {
                            credit.balance = credit.balance + TranAmount
                            print("Transfered from Checkings to Credit")
                            errorLabel.text = ""
                            Alerts().validTransfer(sender: self)
                            
                            dataArray[2].balance = credit.balance
                        }
                        else {
                            print("Credit limit exceeded!")
                            errorLabel.text = "* Credit limit exceeded"
                        }
                    }
                }
                else if fromAccount == 1
                {
                    // SUB from savings
                    savings.available_balance = savings.available_balance - TranAmount
                    savings.balance = savings.balance - TranAmount
                    
                    // Update values in database
                    dataArray[1].available_balance = savings.available_balance
                    dataArray[1].balance = savings.balance
                    
                    if toAccount == 0
                    {
                        // ADD from checking
                        checking.available_balance = checking.available_balance + TranAmount
                        checking.balance = checking.balance + TranAmount
                        print("Transfered from Savings to Checking")
                        errorLabel.text = ""
                        Alerts().validTransfer(sender: self)
                        
                        // Update database
                        dataArray[0].available_balance = checking.available_balance
                        dataArray[0].balance = checking.balance
                    }
                    else
                    {
                        if credit.balance + TranAmount < credit.credit_limit
                        {
                            credit.balance = credit.balance + TranAmount
                            print("Transfered from Savings to Credit")
                            errorLabel.text = ""
                            Alerts().validTransfer(sender: self)
                            
                            dataArray[2].balance = credit.balance
                        }
                        else
                        {
                            print("Credit limit exceeded!")
                            errorLabel.text = "* Credit limit exceeded!"
                        }
                    }
                }
                else
                {
                    print("Cannot transfer from Credit")
                    errorLabel.text = "* Cannot transfer from Credit"
                }
                
                updateAccountValues()
            }
        }
    }
    
    
    //MARK: Functions Below are for Firebase Database
    
    func updateAccountValues() {
        
        let userID : String = Auth.auth().currentUser!.uid
        ref = Database.database().reference()
        
        ref.child("accounts").child(userID).child("checking").updateChildValues(["account_balance": checking.balance,
                                                                                 "available_balance": checking.available_balance
            ])
        ref.child("accounts").child(userID).child("savings").updateChildValues(["account_balance": savings.balance,
                                                                                "available_balance": savings.balance
            ])
        ref.child("accounts").child(userID).child("visa_credit").updateChildValues(["account_balance": credit.balance])
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
