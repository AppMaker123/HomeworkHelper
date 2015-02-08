//
//  PathMenu.swift
//  PathMenu
//
//  Created by pixyzehn on 12/27/14.
//  Copyright (c) 2014 pixyzehn. All rights reserved.
//

import Foundation
import UIKit

@objc protocol PathMenuDelegate:NSObjectProtocol {
    optional func pathMenu(menu: PathMenu, didSelectIndex idx: Int)
    optional func pathMenuDidFinishAnimationClose(menu: PathMenu)
    optional func pathMenuDidFinishAnimationOpen(menu: PathMenu)
    optional func pathMenuWillAnimateOpen(menu: PathMenu)
    optional func pathMenuWillAnimateClose(menu: PathMenu)
}

let kPathMenuDefaultNearRadius: CGFloat = 110.0
let kPathMenuDefaultEndRadius: CGFloat = 120.0
let kPathMenuDefaultFarRadius: CGFloat = 140.0
let kPathMenuDefaultStartPointX: CGFloat = UIScreen.mainScreen().bounds.width/2
let kPathMenuDefaultStartPointY: CGFloat = UIScreen.mainScreen().bounds.height/2
let kPathMenuDefaultTimeOffset: CGFloat = 0.036
let kPathMenuDefaultRotateAngle: CGFloat = 0.0
let kPathMenuDefaultMenuWholeAngle: CGFloat = CGFloat(M_PI) * 2
let kPathMenuDefaultExpandRotation: CGFloat = -CGFloat(M_PI) * 2
let kPathMenuDefaultCloseRotation: CGFloat = CGFloat(M_PI) * 2
let kPathMenuDefaultAnimationDuration: CGFloat = 0.5
let kPathMenuDefaultExpandRotateAnimationDuration: CGFloat = 2.0
let kPathMenuDefaultCloseRotateAnimationDuration: CGFloat = 1.0
let kPathMenuStartMenuDefaultAnimationDuration: CGFloat = 0.2

private func RotateCGPointAroundCenter(point: CGPoint, center:CGPoint, angle: CGFloat) -> CGPoint {
    let translation: CGAffineTransform = CGAffineTransformMakeTranslation(center.x, center.y)
    let rotation: CGAffineTransform = CGAffineTransformMakeRotation(angle)
    let transformGroup: CGAffineTransform = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformInvert(translation), rotation), translation)
    return CGPointApplyAffineTransform(point, transformGroup)
}

class PathMenu: UIView, PathMenuItemDelegate {
   
    enum State {
        case Close // Intial state
        case Expand
    }
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect!, startItem: PathMenuItem?, optionMenus aMenusArray:[PathMenuItem]?) {
        self.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        
        timeOffset = kPathMenuDefaultTimeOffset
        rotateAngle = kPathMenuDefaultRotateAngle
        menuWholeAngle = kPathMenuDefaultMenuWholeAngle
        startPoint = CGPointMake(kPathMenuDefaultStartPointX, kPathMenuDefaultStartPointY)
        expandRotation = kPathMenuDefaultExpandRotation
        closeRotation = kPathMenuDefaultCloseRotation
        animationDuration = kPathMenuDefaultAnimationDuration
        expandRotateAnimationDuration = kPathMenuDefaultExpandRotateAnimationDuration
        closeRotateAnimationDuration = kPathMenuDefaultCloseRotateAnimationDuration
        startMenuAnimationDuration = kPathMenuStartMenuDefaultAnimationDuration
        rotateAddButton = true
        
        nearRadius = kPathMenuDefaultNearRadius
        endRadius = kPathMenuDefaultEndRadius
        farRadius = kPathMenuDefaultFarRadius
 
        menusArray = aMenusArray!
        
        motionState = State.Close
        
        startButton = startItem!
        startButton.delegate = self
        startButton.center = startPoint
        addSubview(startButton)
    }

    var _menusArray: [PathMenuItem] = []
    var menusArray: [PathMenuItem] {
        get {
            return _menusArray
        }
        set(newArray) {
            _menusArray = newArray
            for v in subviews {
                if v.tag >= 1000 {
                    v.removeFromSuperview()
                }
            }
        }
    }
    
    var _startButton: PathMenuItem = PathMenuItem(frame: CGRectZero)
    var startButton: PathMenuItem {
        get {
            return _startButton
        }
        set {
            _startButton = newValue
        }
    }
    
    weak var delegate: PathMenuDelegate!

    var flag: Int?
    var timer: NSTimer?
    
    var timeOffset: CGFloat!
    var rotateAngle: CGFloat!
    var menuWholeAngle: CGFloat!
    var expandRotation: CGFloat!
    var closeRotation: CGFloat!
    var animationDuration: CGFloat!
    var expandRotateAnimationDuration: CGFloat!
    var closeRotateAnimationDuration: CGFloat!
    var startMenuAnimationDuration: CGFloat!
    var rotateAddButton: Bool!
    
    var nearRadius: CGFloat!
    var endRadius: CGFloat!
    var farRadius: CGFloat!
    
    var motionState: State?
    
    var _startPoint: CGPoint = CGPointZero
    var startPoint: CGPoint {
        get {
            return _startPoint
        }
        set {
            _startPoint = newValue
            startButton.center = newValue
        }
    }
    
    // Image
    
    var _image = UIImage()
    var image: UIImage? {
        get {
            return startButton.image
        }
        set(newImage) {
            startButton.image = newImage
        }
    }
    
    var highlightedImage: UIImage? {
        get {
            return startButton.highlightedImage
        }
        set(newImage) {
            startButton.highlightedImage = newImage
        }
    }
    
    var contentImage: UIImage? {
        get {
            return startButton.contentImageView?.image
        }
        set {
            startButton.contentImageView?.image = newValue
        }
    }
    
    var highlightedContentImage: UIImage? {
        get {
            return startButton.contentImageView?.highlightedImage
        }
        set {
            startButton.contentImageView?.highlightedImage = newValue
        }
    }
    
    // UIView's methods
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        if motionState == State.Expand {
            return true
        } else {
            // Close
            return CGRectContainsPoint(startButton.frame, point)
        }
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if let animId: AnyObject = anim.valueForKey("id") {
            if (animId.isEqual("lastAnimation")) {
                delegate?.pathMenuDidFinishAnimationClose?(self)
            }
            if (animId.isEqual("firstAnimation")) {
                delegate?.pathMenuDidFinishAnimationOpen?(self)
            }
        }
    }
    
    // UIGestureRecognizer
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        handleTap()
    }
    
    // PathMenuItemDelegate
    
    func PathMenuItemTouchesBegan(item: PathMenuItem) {
        if (item == startButton) {
            handleTap()
        }
    }
    
    func PathMenuItemTouchesEnd(item:PathMenuItem) {
        
        if (item == startButton) {
            return
        }
        
        let blowup: CAAnimationGroup = blowupAnimationAtPoint(item.center)
        item.layer.addAnimation(blowup, forKey: "blowup")
        item.center = item.startPoint!
        
        for (var i = 0; i < menusArray.count; i++) {
            let otherItem: PathMenuItem = menusArray[i] as PathMenuItem
            let shrink: CAAnimationGroup = shrinkAnimationAtPoint(otherItem.center)
            if (otherItem.tag == item.tag) {
                continue
            }
            otherItem.layer.addAnimation(shrink, forKey: "shrink")
            otherItem.center = otherItem.startPoint!
        }
        
        motionState = State.Close
        delegate?.pathMenuWillAnimateClose?(self)
        
        let angle: CGFloat = motionState == State.Expand ? CGFloat(M_PI_4) + CGFloat(M_PI) : 0.0
        UIView.animateWithDuration(Double(startMenuAnimationDuration!), animations: {() -> Void in
            self.startButton.transform = CGAffineTransformMakeRotation(angle)
        })
        
        delegate?.pathMenu?(self, didSelectIndex: item.tag - 1000)
    }
    
    // Animation, Position
    
    func handleTap() {
        var state = motionState!
        var selector: Selector?
        var angle: CGFloat?
        
        switch state {
        case .Close:
            setMenu()
            delegate?.pathMenuWillAnimateOpen?(self)
            selector = "expand"
            flag = 0
            motionState = State.Expand
            angle = CGFloat(M_PI_2) + CGFloat(M_PI)
        case .Expand:
            delegate?.pathMenuWillAnimateClose?(self)
            selector = "close"
            flag = menusArray.count - 1
            motionState = State.Close
            angle = 0.0
        }
        
        if let rotateAddButton = rotateAddButton {
            UIView.animateWithDuration(Double(startMenuAnimationDuration!), animations: { () -> Void in
                self.startButton.transform = CGAffineTransformMakeRotation(angle!)
            })
        }
        
        if (timer == nil) {
            timer = NSTimer.scheduledTimerWithTimeInterval(Double(timeOffset!), target: self, selector: selector!, userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        }
    }
    
    func expand() {
        
        if flag == menusArray.count {
            timer?.invalidate()
            timer = nil
            return
        }
        
        let tag: Int = 1000 + flag!
        var item: PathMenuItem = viewWithTag(tag) as PathMenuItem
        
        //let rotateAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        //rotateAnimation.values = [NSNumber(float: 0.0), NSNumber(float: Float(expandRotation!)), NSNumber(float: 0.0)]
        //rotateAnimation.duration = CFTimeInterval(expandRotateAnimationDuration!)
        //rotateAnimation.keyTimes = [NSNumber(float: 0.0), NSNumber(float: 0.4), NSNumber(float: 0.5)]
        
        let positionAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = CFTimeInterval(animationDuration!)
        let path: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, CGFloat(item.startPoint!.x), CGFloat(item.startPoint!.y))
        CGPathAddLineToPoint(path, nil, item.farPoint!.x, item.farPoint!.y)
        CGPathAddLineToPoint(path, nil, item.nearPoint!.x, item.nearPoint!.y)
        CGPathAddLineToPoint(path, nil, item.endPoint!.x, item.endPoint!.y)
        positionAnimation.path = path
        
        let animationgroup: CAAnimationGroup = CAAnimationGroup()
        animationgroup.animations = [positionAnimation, /*rotateAnimation*/]
        animationgroup.duration = CFTimeInterval(animationDuration!)
        animationgroup.fillMode = kCAFillModeForwards
        animationgroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animationgroup.delegate = self
        
        if flag == (menusArray.count - 1) {
            animationgroup.setValue("firstAnimation", forKey: "id")
        }
        
        item.layer.addAnimation(animationgroup, forKey: "Expand")
        item.center = item.endPoint!
        
        flag!++
    }
    
    func close() {
        
        if (flag! == -1)
        {
            timer?.invalidate()
            timer = nil
            return
        }
        
        let tag :Int = 1000 + flag!
        var item: PathMenuItem = viewWithTag(tag) as PathMenuItem
        
        //let rotateAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        //rotateAnimation.values = [NSNumber(float: 0.0), NSNumber(float: Float(closeRotation!)), NSNumber(float: 0.0)]
        //rotateAnimation.duration = CFTimeInterval(closeRotateAnimationDuration!)
        //rotateAnimation.keyTimes = [NSNumber(float: 0.0), NSNumber(float: 0.4), NSNumber(float: 0.5)]
        
        let positionAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = CFTimeInterval(animationDuration!)
        let path: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, item.endPoint!.x, item.endPoint!.y)
        CGPathAddLineToPoint(path, nil, item.farPoint!.x, item.farPoint!.y)
        CGPathAddLineToPoint(path, nil, CGFloat(item.startPoint!.x), CGFloat(item.startPoint!.y))
        positionAnimation.path = path
        
        let animationgroup: CAAnimationGroup = CAAnimationGroup()
        animationgroup.animations = [positionAnimation, /*rotateAnimation*/]
        animationgroup.duration = CFTimeInterval(animationDuration!)
        animationgroup.fillMode = kCAFillModeForwards
        animationgroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animationgroup.delegate = self

        if flag == 0 {
            animationgroup.setValue("lastAnimation", forKey: "id")
        }
        
        item.layer.addAnimation(animationgroup, forKey: "Close")
        item.center = item.startPoint!
        
        flag!--
    }
    
    func setMenu() {
        let count: Int = menusArray.count
        var denominator: Int?
        
        for (var i = 0; i < menusArray.count; i++) {
            var item: PathMenuItem = menusArray[i]
            item.tag = 1000 + i
            item.startPoint = startPoint
            
            // avoid overlap
            if (menuWholeAngle >= CGFloat(M_PI) * 2) {
                menuWholeAngle = menuWholeAngle! - menuWholeAngle! / CGFloat(count)
            }
            
            if count == 1 {
                denominator = 1
            } else {
                denominator = count - 1
            }
            
            let i1 = Float(endRadius) * sinf(Float(i) * Float(menuWholeAngle!) / Float(denominator!))
            let i2 = Float(endRadius) * cosf(Float(i) * Float(menuWholeAngle!) / Float(denominator!))
            let endPoint: CGPoint = CGPointMake(startPoint.x + CGFloat(i1), startPoint.y - CGFloat(i2))
            item.endPoint = RotateCGPointAroundCenter(endPoint, startPoint, rotateAngle!)
            
            let j1 = Float(nearRadius) * sinf(Float(i) * Float(menuWholeAngle!) / Float(denominator!))
            let j2 = Float(nearRadius) * cosf(Float(i) * Float(menuWholeAngle!) / Float(denominator!))
            let nearPoint: CGPoint = CGPointMake(startPoint.x + CGFloat(j1), startPoint.y - CGFloat(j2))
            item.nearPoint = RotateCGPointAroundCenter(nearPoint, startPoint, rotateAngle!)

            let k1 = Float(farRadius) * sinf(Float(i) * Float(menuWholeAngle!) / Float(denominator!))
            let k2 = Float(farRadius) * cosf(Float(i) * Float(menuWholeAngle!) / Float(denominator!))
            let farPoint: CGPoint = CGPointMake(startPoint.x + CGFloat(k1), startPoint.y - CGFloat(k2))
            item.farPoint = RotateCGPointAroundCenter(farPoint, startPoint, rotateAngle!)
            
            item.center = item.startPoint!
            item.delegate = self

            insertSubview(item, belowSubview: startButton)
        }
    }
    
    func blowupAnimationAtPoint(p: CGPoint) -> CAAnimationGroup {
        let positionAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.values = [NSValue(CGPoint: p)]
        positionAnimation.keyTimes = [3]
 
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform")
        scaleAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(3, 3, 1))
        
        let opacityAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = NSNumber(float: 0.0)
        
        let animationgroup: CAAnimationGroup = CAAnimationGroup()
        animationgroup.animations = [positionAnimation, scaleAnimation, opacityAnimation]
        animationgroup.duration = CFTimeInterval(animationDuration!)
        animationgroup.fillMode = kCAFillModeForwards
        
        return animationgroup
    }
    
    func shrinkAnimationAtPoint(p: CGPoint) -> CAAnimationGroup {
        let positionAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.values = [NSValue(CGPoint: p)]
        positionAnimation.keyTimes = [3]
        
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform")
        scaleAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(0.01, 0.01, 1))

        let opacityAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = NSNumber(float: 0.0)
        
        let animationgroup: CAAnimationGroup = CAAnimationGroup()
        animationgroup.animations = [positionAnimation, scaleAnimation, opacityAnimation]
        animationgroup.duration = CFTimeInterval(animationDuration!)
        animationgroup.fillMode = kCAFillModeForwards
        
        return animationgroup
    }
}
