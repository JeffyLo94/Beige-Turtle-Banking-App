//
//  AccountTableViewCell.swift
//  BankingApp
//
//  Created by Jeffrey Lo on 7/23/18.
//  Copyright © 2018 brad. All rights reserved.
//

import Foundation
import UIKit

class AccountTableViewCell: UITableViewCell {
    
//    @IBOutlet var imageViewResult: UIImageView!
//    @IBOutlet var imageViewFace: UIImageView!
//    @IBOutlet var labelStatus: UILabel!
//    @IBOutlet var labelTimestamp: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var balance: UILabel!
    @IBOutlet var subTitle: UILabel!
    
    var account: account?
}
