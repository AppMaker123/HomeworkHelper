//
//  TeachersViewController.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/7/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import UIKit
import CoreData

class TeachersViewController: UIViewController, UITableViewDelegate, PathMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        createPathMenu()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Path Menu
    
    func createPathMenu() {
        // Define the Images to be used in the menu
        let storyMenuItemImage        = UIImage(named: "bg-menuitem.png")
        let storyMenuItemImagePressed = UIImage(named: "bg-menuitem-highlighted.png")
        let starImage                 = UIImage(named: "icon-star.png")
        
        // Define the Menu Items
        let starMenuItem1 = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, contentImage: starImage, highlightedContentImage: starImage)
        let starMenuItem2 = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, contentImage: starImage, highlightedContentImage: starImage)
        let starMenuItem3 = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, contentImage: starImage, highlightedContentImage: starImage)
        let starMenuItem4 = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, contentImage: starImage, highlightedContentImage: starImage)
        
        var menus: [PathMenuItem] = [starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4]
        
        let startItem: PathMenuItem = PathMenuItem(image: UIImage(named: "bg-addbutton"), highlightedImage: UIImage(named: "bg-addbutton-highlighted"), contentImage: UIImage(named: "icon-plus"), highlightedContentImage: UIImage(named: "icon-plus-highlighted"))
        
        var menu: PathMenu = PathMenu(frame: view.bounds, startItem: startItem, optionMenus: menus)
        
        menu.startPoint = CGPoint(x: view.frame.size.width - 50.0, y: view.frame.size.height - 50.0)
        
        menu.menuWholeAngle = CGFloat(M_PI / 180 * 95)
        menu.rotateAngle    = CGFloat(M_PI / 180 * -95)
        menu.farRadius      = 120.0
        menu.nearRadius     = 100.0
        menu.endRadius      = 100.0
        menu.timeOffset     = 0.0
        menu.delegate       = self
        view.addSubview(menu)
        view.bringSubviewToFront(menu)
        
    }
    
    func pathMenu(menu: PathMenu, didSelectIndex idx: Int) {
        switch idx {
        case 0: // Assignments
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
            
            break
        case 1: // Grades
            var storyboard = UIStoryboard(name: "Grades", bundle: nil)
            var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
            
            break
        case 2: // Classes
            var storyboard = UIStoryboard(name: "Classes", bundle: nil)
            var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
            
            break
        case 3: // Teachers
            var storyboard = UIStoryboard(name: "Teachers", bundle: nil)
            var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
            
            break
        default: // Default
            break
        }
    }
    
    // MARK: End Path Menu -
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        
        return cell
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}
