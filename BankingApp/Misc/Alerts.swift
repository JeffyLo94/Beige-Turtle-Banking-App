//
//  Alerts.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/9/18.
//  Copyright © 2018 brad. All rights reserved.
//

import Foundation
import UIKit


class Alerts: UIViewController {

    
    func invalidLogin(sender: UIViewController) {
        
        let alert = UIAlertController(title: "Invalid", message: "The email or password is invalid.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        sender.present(alert, animated: true)
    }
    
    func validTransfer(sender: UIViewController) {
        
        let alert = UIAlertController(title: "Valid", message: "Transfer succeeded!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        sender.present(alert, animated: true)
    }


}
