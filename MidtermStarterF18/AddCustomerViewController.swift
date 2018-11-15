//
//  AddCustomerViewController.swift
//  MidtermStarterF18
//
//  Created by parrot on 2018-11-14.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import CoreData

class AddCustomerViewController: UIViewController {
 var context:NSManagedObjectContext!
    var index = 0
    // MARK: Outlets
    // ---------------------
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var startingBalanceTextBox: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    var id = ""
    var name = ""
    var balance  = 0.0
    
    // MARK: Default Functions
    // ---------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
     
        self.context = appDelegate.persistentContainer.viewContext

        print("index = ", index)
        
    
        
    
        
        // HINT HINT HINT HINT HINT
        // HINT HINT HINT HINT HINT
        // Code to create a random 4 digit string
        var x:String = ""
        repeat {
            // Create a string with a random number 0...9991
            x = String(format:"%04d", arc4random_uniform(9992) )
        } while x.count < 4
        
        print("Random value: \(x)")
        id = x
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: Actions
    // ---------------------
    
    @IBAction func createAccountPressed(_ sender: Any) {
        print("you pressed the create account button!")
        name  = nameTextBox.text!
        balance = Double(startingBalanceTextBox.text!)!
        
        let p = Customer(context: self.context)
        p.id  = id
        p.name = name
        p.balance  = balance
        
        do {
            // Save the user to the database
            // (Send the INSERT to the database)
            try self.context.save()
            print("data saved")
            messageLabel.text = "Account Created Successfully \n Your Customer Id is : \(id)"
            
        }
        
        catch {
            print("Error while saving to database")
            messageLabel.text = "Please try again later"
        }
            

        
      //  message = "";
        
        
        
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
