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

    let fieldHeight:CGFloat = 50.0
    let fieldMargin:CGFloat = 10.0
    let fieldFontSize:CGFloat = 18.0
    let fieldFloatingLabelFontSize:CGFloat = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "green-shadow")
        
        title = NSLocalizedString("Add Class", comment: "Title for the page. Page allows user to add a new class.")
        
        let floatingLabelColor = view.tintColor
        
        let div0 = UIView()
        div0.frame = CGRect(x: fieldMargin, y: 4, width: view.frame.size.width - (2.0 * fieldMargin), height: 1.0)
        div0.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.0)
        view.addSubview(div0)
        
        //Defines the Class Name Field
        let classNameField = JVFloatLabeledTextField(frame: CGRect(x: fieldMargin , y: div0.frame.origin.y + div0.frame.size.height, width: view.frame.size.width - (2 * fieldMargin), height: fieldHeight))
        classNameField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Class Name", comment: "The Name of the Class"), attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
        classNameField.font = UIFont.systemFontOfSize(fieldFontSize)
        classNameField.floatingLabel.font = UIFont.boldSystemFontOfSize(fieldFloatingLabelFontSize)
        classNameField.clearButtonMode = .WhileEditing
        view.addSubview(classNameField)
        
        let div1 = UIView()
        div1.frame = CGRect(x: fieldMargin, y: classNameField.frame.origin.y + classNameField.frame.size.height, width: view.frame.size.width - (2 * fieldMargin), height: 1.0)
        div1.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        view.addSubview(div1)
        
        //Defines the Select Teacher Button
        let teacherButton = UIButton(frame: CGRect(x: fieldMargin , y: div1.frame.origin.y + div1.frame.size.height, width: view.frame.size.width - (2 * fieldMargin), height: fieldHeight))
        teacherButton.buttonType
        teacherButton.setAttributedTitle(NSAttributedString(string: NSLocalizedString("Select Teacher", comment: "The Name of the Class"), attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()]), forState: .Normal)
        teacherButton.titleLabel?.font = UIFont.systemFontOfSize(fieldFontSize)
        teacherButton.contentHorizontalAlignment = .Left;
        let size = teacherButton.frame.size
        let arrow = UIImage(named: "drop-down-arrow")!
        teacherButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: teacherButton.frame.width - 35, bottom: 0, right: 0)
        teacherButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -arrow.size.width, bottom: 0, right: 0)

        teacherButton.setImage(arrow, forState: .Normal)
        teacherButton.selected = false
        view.addSubview(teacherButton)
        
        let div2 = UIView()
        div2.frame = CGRect(x: fieldMargin, y: teacherButton.frame.origin.y + teacherButton.frame.size.height, width: view.frame.size.width - (2 * fieldMargin), height: 1.0)
        div2.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        view.addSubview(div2)
        
        let blankDiv = UIView()
        blankDiv.frame = CGRect(x: fieldMargin, y: div2.frame.origin.y + div2.frame.size.height, width: view.frame.size.width - (2 * fieldMargin), height: fieldHeight)
        blankDiv.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.0) // Extra Clear!
        view.addSubview(blankDiv)
        
        let div3 = UIView()
        div3.frame = CGRect(x: fieldMargin, y: blankDiv.frame.origin.y + blankDiv.frame.size.height, width: view.frame.size.width - (2 * fieldMargin), height: 1.0)
        div3.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        view.addSubview(div3)
        // TODO: Add Two Buttons for the start and end date of the class with an arrow on the right side. The dropdown will be a calendar (NOT a date picker).
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}