//
//  Accounts.swift
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

class Accounts: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        setUserData()
        print("In Portfolio...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ListToAccountDetails"){
            if sender is AccountTableViewCell {
                let cell = sender as! AccountTableViewCell
                let acctDetailsVC = segue.destination as! AccountDetails
                acctDetailsVC.account = cell.account
            }
        }
    }
    
    func setUserData() {
        
        welcomeLabel.text = "Welcome, " + client.name

        for (index, element) in dataArray.enumerated() {
            
            portfolioArray.insert(data(title: element.name, balance: element.balance.currency, title2: "Account Balance"), at: index)
            
            //Set a struct for savings and checking
            if(element.name == "Checking"){
                checking.name = element.name
                checking.balance = element.balance
                checking.available_balance = element.available_balance
            }
            if(element.name == "Savings"){
                savings.name = element.name
                savings.balance = element.balance
                savings.available_balance = element.available_balance
         
        }
      
       
    }
    
    }

    
    
    //MARK: TableView Data & Cell Management
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//
//        let title = cell?.viewWithTag(1) as! UILabel
//        let balance = cell?.viewWithTag(2) as! UILabel
//        let title2 = cell?.viewWithTag(3) as! UILabel
        
        cell.account = dataArray[indexPath.row]
        cell.title.text = portfolioArray[indexPath.row].title
        cell.balance.text = portfolioArray[indexPath.row].balance
        cell.subTitle.text = portfolioArray[indexPath.row].title2
        
        return cell
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\nNumber of Accounts: \(dataArray.count)\n")
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
        
        
//        performSegue(withIdentifier: "ListToAccountsDetails", sender: nil)
        
    }
    
    

   

}//END CLASS
