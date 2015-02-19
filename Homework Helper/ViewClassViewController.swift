//
//  ViewClassViewController.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/7/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import UIKit
import CoreData

class ViewClassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "green-shadow")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
