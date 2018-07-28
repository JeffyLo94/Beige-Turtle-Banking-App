//
//  AccountDetails.swift
//  BankingApp
//
//  Created by Jeffrey Lo on 7/23/18.
//  Copyright © 2018 brad. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

struct transaction {
    let description: String!
}

class AccountDetails: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //UI ELEMENTS
    @IBOutlet var acctTypeLabel: UILabel!
    @IBOutlet var balanceValue: UILabel!
    @IBOutlet var acctSubLabel: UILabel!
    @IBOutlet var acctOverview: UIView!
    @IBOutlet var creditCardView: UIView!
    @IBOutlet var creditCardTitle: UILabel!
    @IBOutlet var creditLimitTitle: UILabel!
    @IBOutlet var creditLimitValue: UILabel!
    @IBOutlet var creditCardImage: UIImageView!
    @IBOutlet var cardSwitch: UISwitch?
    @IBOutlet var scroller: UIScrollView!
    
    
    @IBOutlet weak var tableView: UITableView!
    var transactionsArray = [transaction]()
    var ref: DatabaseReference!
    
    
    //Border Stuff:
    let borderSize:CGFloat = 2.0
    let borderColor:CGColor = UIColor(displayP3Red: 94/255, green: 178/255, blue: 237/255, alpha: 0.95).cgColor

    
    var account: account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView Initialization
        tableView.delegate = self
        tableView.dataSource = self
        
        self.cardSwitch?.isOn = true
        self.cardSwitch?.transform = CGAffineTransform(scaleX: 1.0, y: 0.9)
//        self.acctOverview.layer.borderColor = borderColor
//        self.acctOverview.layer.borderWidth = borderSize
//        self.creditCardView.layer.borderColor = borderColor
//        self.creditCardView.layer.borderWidth = borderSize
        
        scroller.contentSize = CGSize(width: scroller.contentSize.width, height: 1000)
        populateData()
        
        transactionsArray.removeAll() //Testing for saftey
        loadTransactions() //Firebase Transactions
       
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        creditCardView.isHidden = true;
        if (account?.name == "Visa Credit"){
            creditCardView.isHidden = false;
        }
    }
    
    func populateData(){
        self.acctTypeLabel.text = account?.name
        self.balanceValue.text = account?.balance.currency
    }
    
    
    
    
    //TableView Functionality
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let transactoinLabel = cell?.viewWithTag(1) as! UILabel
        transactoinLabel.text = transactionsArray[indexPath.row].description
        
        if transactoinLabel.text?.first == "W" {
            transactoinLabel.textColor = UIColor.red
        }else {
            transactoinLabel.textColor = UIColor(red: 0, green: 128/255, blue: 0, alpha: 1)
        }
        
        return cell!
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
    }
    
    
    //Load TableView Data (Load Transactions from firebase)
    
    func loadTransactions() {
        
        ref = Database.database().reference()
        let userID : String = Auth.auth().currentUser!.uid
        let accountType: String = (account?.name)!
        
        ref.child("transactions").child(userID).child(accountType).queryOrderedByKey().observe(.childAdded, with: {snapshot in
            
            let snapDict = snapshot.value as? NSDictionary
            let transactionDescription = snapDict?["transaction"] as? String ?? ""
            self.transactionsArray.insert(transaction(description: transactionDescription), at: 0)
            self.tableView.reloadData()
            
        })
        
   
        
    }
    
    
    
    
    
}//END CLASS
