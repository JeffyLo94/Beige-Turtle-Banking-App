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

class AccountDetails: UIViewController {
    
    //UI ELEMENTS
    @IBOutlet var acctTypeLabel: UILabel!
    @IBOutlet var balanceValue: UILabel!
    @IBOutlet var acctSubLabel: UILabel!
    @IBOutlet var acctOverview: UIView!
    
    //Border Stuff:
    let borderSize:CGFloat = 2.0
    let borderColor:CGColor = UIColor(displayP3Red: 94/255, green: 178/255, blue: 237/255, alpha: 0.95).cgColor

    
    var account: account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setUserData()
//
//        //TableView Assignment
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.tableFooterView = UIView()
        
        self.acctOverview.layer.borderColor = borderColor
        self.acctOverview.layer.borderWidth = borderSize
//        self.acctDetailsView.layer.borderColor = borderColor
//        self.acctDetailsView.layer.borderWidth = borderSize

        populateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        setUserData()
        
        print("In Account Details...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    func populateData(){
        self.acctTypeLabel.text = account?.name
        self.balanceValue.text = account?.balance.currency
    }
}
