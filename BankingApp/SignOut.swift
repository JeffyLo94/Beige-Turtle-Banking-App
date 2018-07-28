//
//  SignOut.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/27/18.
//  Copyright © 2018 brad. All rights reserved.
//

import UIKit

class SignOut: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        signOut()
        
    }

    
    func signOut() {
        dataArray.removeAll()
        self.dismiss(animated: true, completion: {});
        self.navigationController?.popViewController(animated: true);
        
    }
    
    
    
    
    

}
