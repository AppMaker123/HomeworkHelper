//
//  AddClassViewController.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/7/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import UIKit
import CoreData

class AddClassViewController: UITableViewController {
    
    @IBOutlet weak var txtStartDate: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var txtEndDate: UILabel!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet var daysOfWeekControl: UISegmentedControl!
    
    private var startDatePickerHidden = false
    private var endDatePickerHidden = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "green-shadow")
        startDatePicker.date = NSDate()
        endDatePicker.date = NSDate()
        startDidChangeDate()
        endDidChangeDate()
        toggleStartDatePicker()
        toggleEndDatePicker()
        
    }
    
    @IBAction internal func startDidChangeDate() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd hh:mm:ss"
        let compareResult = startDatePicker.date.compare(endDatePicker.date)
        if compareResult == NSComparisonResult.OrderedDescending {
            startDatePicker.setDate(endDatePicker.date, animated: true)
        }
        txtStartDate.text = NSDateFormatter.localizedStringFromDate(startDatePicker.date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)

    }
    
    @IBAction internal func endDidChangeDate() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd hh:mm:ss"
        let compareResult = endDatePicker.date.compare(startDatePicker.date)
        if compareResult == NSComparisonResult.OrderedAscending {
            endDatePicker.setDate(startDatePicker.date, animated: true)
        }
        txtEndDate.text = NSDateFormatter.localizedStringFromDate(endDatePicker.date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            toggleStartDatePicker()
            if !endDatePickerHidden {
                toggleEndDatePicker()
            }
        case (1, 2):
            toggleEndDatePicker()
            if !startDatePickerHidden {
                toggleStartDatePicker()
            }
        default:
            if !startDatePickerHidden {
                toggleStartDatePicker()
            }
            if !endDatePickerHidden {
                toggleEndDatePicker()
            }
            break
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if startDatePickerHidden && indexPath.section == 1 && indexPath.row == 1 {
            return 0
        } else if endDatePickerHidden && indexPath.section == 1 && indexPath.row == 3 {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    private func toggleStartDatePicker() {
        startDatePickerHidden = !startDatePickerHidden
        
        // Force table to update its contents
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    private func toggleEndDatePicker() {
        endDatePickerHidden = !endDatePickerHidden
        
        // Force table to update its contents
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
