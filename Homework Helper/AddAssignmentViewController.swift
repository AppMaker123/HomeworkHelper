//
//  AddAssignmentViewController.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/7/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import UIKit
import CoreData

class AddAssignmentViewController: UITableViewController {
    
    var managedContext: NSManagedObjectContext!
    
    @IBOutlet var txtAssName: UITextField!
    @IBOutlet var txtNotes: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var dateSelected: UILabel!
    @IBOutlet var classSelected: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "blue-shadow")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Implement the addName IBAction
    @IBAction func save(sender: AnyObject) {
        
        if txtAssName != nil {
            if dateSelected != nil {
                if classSelected != nil {
                    
                } else {
                    println("Select a Class for the Assignment")
                }
            } else {
                println("Enter a Due Date")
            }
        } else {
            println("Type in a name before saving")
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        let assignmentVC = segue.destinationViewController as! AssignmentsTableViewController
    }
}
