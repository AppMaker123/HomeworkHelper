//
//  Menu.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/8/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import UIKit

@objc protocol MenuDelegate {
    optional func getCurrentViewController() -> UIViewController
    optional func pathMenu(menu: PathMenu, didSelectIndex idx: Int)
}

class Menu: NSObject, PathMenuDelegate, MenuDelegate {
    
    var delegate: MenuDelegate?
    var indx:Int?
    
    func createPathMenu() {
        let view = delegate?.getCurrentViewController!().view
        
        // Define the Images to be used in the menu
        let menuItemBackground = [
            UIImage(named: "bg-icon-blue"),
            UIImage(named: "bg-icon-yellow"),
            UIImage(named: "bg-icon-green"),
            UIImage(named: "bg-icon-purple")]
        let menuItemBackgroundPressed = [
            UIImage(named: "bg-icon-blue-pressed"),
            UIImage(named: "bg-icon-yellow-pressed"),
            UIImage(named: "bg-icon-green-pressed"),
            UIImage(named: "bg-icon-purple-pressed")]
        let menuItemIcon = [
            UIImage(named: "bg-icon-blue-icon"),
            UIImage(named: "bg-icon-yellow-icon"),
            UIImage(named: "bg-icon-green-icon"),
            UIImage(named: "bg-icon-purple-icon")]

        // Define the Menu Items
        let starMenuItem1 = PathMenuItem(image: menuItemBackground[0], highlightedImage: menuItemBackgroundPressed[0], contentImage: menuItemIcon[0], highlightedContentImage: menuItemIcon[0])
        let starMenuItem2 = PathMenuItem(image: menuItemBackground[1], highlightedImage: menuItemBackgroundPressed[1], contentImage: menuItemIcon[1], highlightedContentImage: menuItemIcon[1])
        let starMenuItem3 = PathMenuItem(image: menuItemBackground[2], highlightedImage: menuItemBackgroundPressed[2], contentImage: menuItemIcon[2], highlightedContentImage: menuItemIcon[2])
        let starMenuItem4 = PathMenuItem(image: menuItemBackground[3], highlightedImage: menuItemBackgroundPressed[3], contentImage: menuItemIcon[3], highlightedContentImage: menuItemIcon[3])
        
        var menus: [PathMenuItem] = [starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4]
        
        let startItem: PathMenuItem = PathMenuItem(image: UIImage(named: "bg-menu-button"), highlightedImage: UIImage(named: "bg-menu-button-pressed"), contentImage: UIImage(), highlightedContentImage: UIImage())
        
        var menu: PathMenu = PathMenu(frame: view?.bounds, startItem: startItem, optionMenus: menus)
        
        menu.startPoint = CGPoint(x: view!.frame.size.width - 55.0, y: view!.frame.size.height - 120.0)
        
        menu.menuWholeAngle = CGFloat(M_PI / 180 * 95)
        menu.rotateAngle    = CGFloat(M_PI / 180 * -95)
        menu.farRadius      = 120.0
        menu.nearRadius     = 95.0
        menu.endRadius      = 100.0
        menu.timeOffset     = 0.025
        menu.delegate       = self
        view?.addSubview(menu)
        view?.bringSubviewToFront(menu)
        
    }
    
    func pathMenu(menu: PathMenu, didSelectIndex idx: Int) {
        
        // Delays showing the next view to allow the animation to finish first
        let delayInSeconds = 0.2
        let startTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(startTime, dispatch_get_main_queue()) { () -> Void in
            
            switch idx {
            case 0: // Assignments
                var storyboard = UIStoryboard(name: "Main", bundle: nil)
                var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as! UIViewController
                controller.modalTransitionStyle = .CrossDissolve
                self.delegate?.getCurrentViewController!().presentViewController(controller, animated: true, completion: nil)
                
                break
            case 1: // Grades
                var storyboard = UIStoryboard(name: "Grades", bundle: nil)
                var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as! UIViewController
                controller.modalTransitionStyle = .CrossDissolve
                self.delegate?.getCurrentViewController!().presentViewController(controller, animated: true, completion: nil)
                
                break
            case 2: // Classes
                var storyboard = UIStoryboard(name: "Classes", bundle: nil)
                var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as! UIViewController
                controller.modalTransitionStyle = .CrossDissolve
                self.delegate?.getCurrentViewController!().presentViewController(controller, animated: true, completion: nil)
                
                break
            case 3: // Teachers
                var storyboard = UIStoryboard(name: "Teachers", bundle: nil)
                var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as! UIViewController
                controller.modalTransitionStyle = .CrossDissolve
                self.delegate?.getCurrentViewController!().presentViewController(controller, animated: true, completion: nil)
                
                break
            default: // Default
                break
            }
            
        }

    }
    
}
