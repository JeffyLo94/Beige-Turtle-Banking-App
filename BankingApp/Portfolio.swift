//
//  Portfolio.swift
//  BankingApp
//
//  Created by Bradley Dodds on 7/9/18.
//  Copyright © 2018 brad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct data {
    let title: String!
    let balance: String!
    let title2: String!
}

class Portfolio: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    
    var portfolioArray = [data]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserData()
        
        //TableView Assignment
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
       
    }
    
    
    
    
    func setUserData() {
        
        welcomeLabel.text = "Welcome, " + client.name
        
        portfolioArray.insert(data(title: "Checking Account", balance: client.checking.currency, title2: "Account Balance"), at: 0)
        
        portfolioArray.insert(data(title: "Savings Account", balance: client.saving.currency, title2: "Account Balance"), at: 1)
        
        portfolioArray.insert(data(title: "Total Account Value", balance: (client.saving + client.checking).currency, title2: nil), at: 2)
        
      
       
    }
    
   

    
    
    //MARK: TableView Data & Cell Management
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let title = cell?.viewWithTag(1) as! UILabel
        let balance = cell?.viewWithTag(2) as! UILabel
        let title2 = cell?.viewWithTag(3) as! UILabel
        
        
        title.text = portfolioArray[indexPath.row].title
        balance.text = portfolioArray[indexPath.row].balance
        title2.text = portfolioArray[indexPath.row].title2
        
        return cell!
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
    }
    
    

   

}//END CLASS
