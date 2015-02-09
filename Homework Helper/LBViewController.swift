//
//  LBViewController.swift
//  HamburgerButton
//
//  Created by Bang Nguyen on 03/09/2014.
//  Copyright (c) Năm 2014 Bang Nguyen. All rights reserved.
//

import UIKit

class LBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var hamburgerButtonCloseBig = LBHamburgerButton(frame: CGRectMake(0, 0, 104, 104), type: LBHamburgerButtonType.CloseButton, lineWidth: 50, lineHeight: 50/6, lineSpacing: 5, lineCenter: CGPointMake(52, 52), color: UIColor.whiteColor())
        hamburgerButtonCloseBig.center = CGPointMake(120, 120)
        hamburgerButtonCloseBig.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(hamburgerButtonCloseBig)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender: UIButton) {
        var btn = sender as LBHamburgerButton
        btn.switchState()
    }

}
