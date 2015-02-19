//
//  HomeworkCell.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/14/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import UIKit

class HomeworkCell: UITableViewCell {

    var color:UIColor!, title:String!, txtBottomRight:String!, txtTopRight:String!, shortName:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title = nil
        txtBottomRight = nil
        txtTopRight = nil
        shortName = nil
        color = nil
    }
    
    override func drawRect(rect: CGRect) {
        drawCell(color: self.color, title: self.title, txtBottomRight: self.txtBottomRight, txtTopRight: self.txtTopRight, shortName: self.shortName)
    }
    
    func drawCell(#color: UIColor, title: String, txtBottomRight: String, txtTopRight: String, shortName: String) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color View Drawing
        let colorViewPath = UIBezierPath(rect: CGRectMake(0, 0, 40, 90))
        color.setFill()
        colorViewPath.fill()
        
        
        //// Text Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 0, 90)
        CGContextRotateCTM(context, -90 * CGFloat(M_PI) / 180)
        
        let textRect = CGRectMake(0, 0, 90, 40)
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(20.0), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = NSString(string: shortName).boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        NSString(string: shortName).drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
        
        CGContextRestoreGState(context)
        
        
        //// Name Drawing
        let nameRect = CGRectMake(50, 0, 195, 90)
        let nameStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        nameStyle.alignment = NSTextAlignment.Left
        
        let nameFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(25), NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: nameStyle]
        
        let nameTextHeight: CGFloat = NSString(string: title).boundingRectWithSize(CGSizeMake(nameRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: nameFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, nameRect);
        NSString(string: title).drawInRect(CGRectMake(nameRect.minX, nameRect.minY + (nameRect.height - nameTextHeight) / 2, nameRect.width, nameTextHeight), withAttributes: nameFontAttributes)
        CGContextRestoreGState(context)
        
        
        //// Top Right Text Drawing
        let topRightTextRect = CGRectMake(frame.width - 70, 0, 70, 44)
        let topRightTextStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        topRightTextStyle.alignment = NSTextAlignment.Center
        
        let topRightTextFontAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(UIFont.labelFontSize()), NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: topRightTextStyle]
        
        let topRightTextTextHeight: CGFloat = NSString(string: txtTopRight).boundingRectWithSize(CGSizeMake(topRightTextRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: topRightTextFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, topRightTextRect);
        NSString(string: txtTopRight).drawInRect(CGRectMake(topRightTextRect.minX, topRightTextRect.minY + topRightTextRect.height - topRightTextTextHeight, topRightTextRect.width, topRightTextTextHeight), withAttributes: topRightTextFontAttributes)
        CGContextRestoreGState(context)
        
        
        //// Bottom Right Text Drawing
        let bottomRightTextRect = CGRectMake(frame.width - 70, 44, 70, 46)
        let bottomRightTextStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        bottomRightTextStyle.alignment = NSTextAlignment.Center
        
        let bottomRightTextFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(UIFont.labelFontSize()), NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: bottomRightTextStyle]
        
        NSString(string: txtBottomRight).drawInRect(bottomRightTextRect, withAttributes: bottomRightTextFontAttributes)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
