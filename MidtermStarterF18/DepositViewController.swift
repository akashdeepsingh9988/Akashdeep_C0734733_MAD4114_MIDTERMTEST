//
//  DepositViewController.swift
//  MidtermStarterF18
//
//  Created by parrot on 2018-11-14.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import CoreData

class DepositViewController: UIViewController {
    var index = 0;
    var currentBalance  = 0.0
    var name = ""
    var id = ""
     let fetchRequest:NSFetchRequest<Customer> = Customer.fetchRequest()
var context:NSManagedObjectContext!
    // MARK: Outlets
    // ---------------------
    @IBOutlet weak var customerIdTextBox: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!

    @IBOutlet weak var depositAmountTextBox: UITextField!
    @IBOutlet weak var messagesLabel: UILabel!
    var custid = ""
    
    // MARK: Default Functions
    // ---------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        self.context = appDelegate.persistentContainer.viewContext
       

        print("You are on the Check Balance screen!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    // MARK: Actions
    // ---------------------
    
    
    @IBAction func checkBalancePressed(_ sender: Any) {
        print("check balance button pressed!")
         custid =  customerIdTextBox.text!
       
        
        fetchRequest.predicate =  NSPredicate(format: "id == %@", custid)
                do {
            
            let results = try self.context.fetch(fetchRequest) as [Customer]
            
            // Loop through the database results and output each "row" to the screen
            print("Number of items in database: \(results.count)")
            
            if (results.count == 1) {
                // editScreen.person = results[0] as P
                
                for x in results {
                    
                    print("Balance \(x.balance)")
                    name = x.name!
                    id = x.id!
                
                    balanceLabel.text = String(x.balance)
                    currentBalance = x.balance
                }
                
            }
            
        }
        catch {
            print("Error when fetching from database")
        }
        
        
        
    }
    
    
    @IBAction func depositButtonPressed(_ sender: Any) {
        print("you pressed the deposit button!")
        var amount = Double(depositAmountTextBox.text!)!
        var total = currentBalance+amount
        
        if(custid == nil || custid == "")
        {
             messagesLabel.text = "Error! Please try again later"
        }
        
        else
        {
            
                // Save the user to the database
                // (Send the INSERT to the database)
                
                
                
                fetchRequest.predicate = NSPredicate.init(format: "id == %@", custid)
                let objects = try! context.fetch(fetchRequest)
                for obj in objects {
                    context.delete(obj)
                }
                
                do {
                    try context.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
            
        
       // let fetchRequest:NSFetchRequest<Customer> = Customer.fetchRequest()
        //fetchRequest.predicate =  NSPredicate(format: "id == %@", custid)
        let p = Customer(context: self.context)
            p.id = id
            p.name = name
            p.balance  = total
            print("total =" ,total);
        
      
            do{
            try self.context.save()
            print("data saved")
                messagesLabel.text = "Money Deposited \n Previous Balance : $\(currentBalance) \n Deposited Amount: $\(amount) \n New Balance : $\(total)"
                
                
            
        }
            
        catch {
            print("Error while saving to database")
           messagesLabel.text = "Error! Please try again later"
        }
            
        }
       
        }
    
    
    @IBAction func showCustomersPressed(_ sender: Any) {
        print("Show customers button pressed!")
        
        let fetchRequest:NSFetchRequest<Customer> = Customer.fetchRequest()
        // like where
       // fetchRequest.predicate = NSPredicate(format: "email == %@", "michael@gmail.com")
        
        do {
           
            let results = try self.context.fetch(fetchRequest) as [Customer]
            
            // Loop through the database results and output each "row" to the screen
            print("Number of items in database: \(results.count)")
            
            for x in results {
                 print("Customer Name :  \(x.name!)")
                print("Customer Id : \(x.id!)")
               
                print("Balance $\(x.balance)")
                 print("--------------------------------")
            }
        }
        catch {
            print("Error when fetching from database")
        }
    }
        
        


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
