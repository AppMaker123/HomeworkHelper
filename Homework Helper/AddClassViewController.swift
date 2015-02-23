//
//  AddClassViewController.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/7/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import UIKit
import CoreData

class AddClassViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var txtFieldClassName: HoshiTextField!
    @IBOutlet var txtFieldTeacherName: HoshiTextField!
    @IBOutlet var txtFieldStartDate: HoshiTextField!
    @IBOutlet var txtFieldEndDate: HoshiTextField!
    @IBOutlet var lblMeetsOn: UILabel!
    @IBOutlet var dayOfWeekSegment: MultiSelectSegmentedControl!
    // TODO: This is temporary. Move the String out of the struct once static declarations are fixed
    struct Text {
        static var teacherName:String!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldTeacherName.text = Text.teacherName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nameDidEndEditing(sender: AnyObject) {
        // Alerts the user if the Class Name (required) is blank
        if txtFieldClassName.text.isEmpty {
            txtFieldClassName.borderInactiveColor = UIColor.redColor()
        }
    }
    @IBAction func selTeacherPressed(sender: AnyObject) {
        println("Teacher Button Pressed")

    }
    
    @IBAction func startDatePressed(sender: AnyObject) {
        println("Start Button Pressed")
    }
    
    @IBAction func endDatePressed(sender: AnyObject) {
        println("End Button Pressed")
    }
}