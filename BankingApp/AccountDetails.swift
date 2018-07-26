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
    @IBOutlet var creditCardView: UIView!
    @IBOutlet var creditCardTitle: UILabel!
    @IBOutlet var creditLimitTitle: UILabel!
    @IBOutlet var creditLimitValue: UILabel!
    @IBOutlet var creditCardImage: UIImageView!
    @IBOutlet var cardSwitch: UISwitch?
    @IBOutlet var scroller: UIScrollView!
    
    //Border Stuff:
    let borderSize:CGFloat = 2.0
    let borderColor:CGColor = UIColor(displayP3Red: 94/255, green: 178/255, blue: 237/255, alpha: 0.95).cgColor

    
    var account: account?
    
    override func viewDidLoad() {
        
        self.cardSwitch?.isOn = true
        self.cardSwitch?.transform = CGAffineTransform(scaleX: 1.0, y: 0.9)
//        self.acctOverview.layer.borderColor = borderColor
//        self.acctOverview.layer.borderWidth = borderSize
//        self.creditCardView.layer.borderColor = borderColor
//        self.creditCardView.layer.borderWidth = borderSize
        
        scroller.contentSize = CGSize(width: scroller.contentSize.width, height: 1000)
        
        populateData()
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        setUserData()
        

        
        print("In Account Details...")
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
}
