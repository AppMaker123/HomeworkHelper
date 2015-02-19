//
//  AssignmentsTableViewController.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/7/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import UIKit
import CoreData

class AssignmentsTableViewController: UIViewController, UITableViewDelegate, MenuDelegate, PathMenuDelegate, NSFetchedResultsControllerDelegate {

    var fetchedResultsController : NSFetchedResultsController!
    var coreDataStack: CoreDataStack!

    @IBOutlet var tableView: UITableView!
    
    let menu = Menu()
    
    var currentClass: Class!
    var assignment: Assignment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(HomeworkCell.self, forCellReuseIdentifier: "Cell")
        
        menu.delegate = self
        menu.createPathMenu()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "blue-shadow")
        
        /*let fetchRequest = NSFetchRequest(entityName: "Assignment")
        
        let dateSort = NSSortDescriptor(key: "dueDate", ascending: false)
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [dateSort, nameSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self

        var error: NSError? =  nil
        if (!fetchedResultsController.performFetch(&error)) {
            println("Error: \(error?.localizedDescription)")
        }*/
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

    }
    
    func getCurrentViewController() -> UIViewController {
        return self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView (tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        
        return 1
    }
    
    // TODO: Add a 'rate us' button at index 5 (inline and unintrusive -- Circa)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:HomeworkCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! HomeworkCell
        
        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: HomeworkCell, indexPath: NSIndexPath) {
        /*
        let assignment = fetchedResultsController.objectAtIndexPath(indexPath) as! Assignment
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        
        cell.backgroundColor = UIColor.clearColor()
        cell.title = assignment.name
        cell.color = currentClass.color as! UIColor
        cell.txtTopRight = "Due:"
        cell.txtBottomRight = dateFormatter.stringFromDate(assignment.dueDate)
        cell.shortName = currentClass.fourCharName.uppercaseString
        */
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        
        cell.backgroundColor = UIColor.clearColor()
        cell.title = "Hello, World!"
        cell.color = UIColor.hhGreenColor()
        cell.txtTopRight = "Due:"
        cell.txtBottomRight = dateFormatter.stringFromDate(NSDate())
        cell.shortName = "Swift".uppercaseString
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let addAssignmentVC = segue.destinationViewController as! AddAssignmentViewController
    }
}
