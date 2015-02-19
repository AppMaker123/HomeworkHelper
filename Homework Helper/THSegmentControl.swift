//
//  THMultipleSelectionSegmentedControl.h
//  THMultipleSelectionSegmentedControl
//
//  Originally Created by Taylor Halliday on 11/20/13.
//  Copyright (c) 2013 5Celsius. All rights reserved.
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
////////////////////////////////////////////////////////////////////////////////////////
//  
//  Ported to Swift 2.1 by Cory Ginsberg on 2/18/15
//  Copyright (c) 2015 Boiling Point Dev. All rights reserved.
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
////////////////////////////////////////////////////////////////////////////////////////

import UIKit

/**
`THSegmentedControlSegmentDelegate` is designed to let the owner of this control decide whether or not to allow a specific content selection.
If not implemented, the control will default to allowing all segments to be selected.
*/
@objc protocol THSegmentControlDelegate {
    
    /**  
    Delegate callback that optionally allows the delegate to decide whether or not to allow the control to show the tapped item as selected.

    :param: index                  The index of the tapped index
    :param: requestedSelectedState The proposed state of the segment

    :returns: Boolean value indicating YES for ok to proceed, and NO for ignore.
    */
    
    optional func allowSegmentWithIndex(index: NSInteger, toToggleAsSelected requestedSelectedState:Bool)
    
     func allowSegment(segment:THSegmentedControlSegment, toHighlight highlighted:Bool, withIndex index:NSInteger)
}

/**
'THSegmentedControl' creates and returns a UIControl subclass
that closely resembles the stock UISegmentedControl, but adds support for allowing multiple segment selection.
*/

// MARK: -
// TODO: Add support for using images

let THSegmentedControlSeperatorWidth = 1
let THSegmentedControlAnimationDuration = 0.1

protocol THSegmentedControl: THSegmentControlDelegate {
    var segments:NSMutableArray!
    var segmentLabels:NSMutableArray!
    var segmentSeperators:NSMutableArray!
    var selectedIndexPath:NSMutableOrderedSet!
}

@objc class THSegmentControl: UIControl {
    
    //------------------------
    // MARK: - Appearance Properties. All adhere to UIAppearance Proxies
    //------------------------
    
    /**
    Background color of unselected cells. The inverse of this color will be the font color within the cell.
    */
    var cellBackgroundColor: UIColor!
    
    /**
    Background color of selected cells. The inverse of this color will be the font color within the cell.
    */
    var cellTintColor: UIColor!
    
    /**
    UIFont to be used within cells
    */
    var cellFont: UIFont!
    
    //------------------------
    // MARK: - THSegmentedControl Delegate
    //------------------------
    
    weak var delegate:THSegmentControlDelegate!

    //------------------------
    // MARK: - Initialization
    //------------------------
    
    /**
    Creates and returns an instance of THSegmentedControl with the provides segments
    
    @param segments The array of segments. These are all assumed to be instances of NSSTring *
    
    @return An instance of THSegmentedControl
    */
    init(segments:NSArray) {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //------------------------
    // MARK: - Control State Properties
    //------------------------
    
    /**
    Sets the selected indexes
    
    :param: selectedIndexes NSOrderedSet of selected indexes
    */
    func setSelectedIntexes(selectedIndexes: NSOrderedSet) {
        
    }
    
    /**
    Returns the index set of the currently selected indexes
    
    :returns: Selected indexes
    */
    func selectedIndexes() -> NSOrderedSet {
        
    }
    
    //------------------------
    // MARK: - Getter / Setter Methods for Segments and Their Values
    //------------------------
    
    
    /**
    Set control segments by index with title. If the segments are not sequentually loaded,
    a blank string ("") will take the missing segments' place. Will not throw an exception for
    placing segments out of sequence.
    
    :param: title   Title of the segment to be set
    :param: segment Index location of the segment to be set
    */
    func insertSegmentWithTitle(title: String, atIndex segment:UInt) {
        
    }
    
    /**
    Receive array of titles for segments.
    
    :param: Indexes An ordered set of indexes
    
    :returns: An array of titles for the segments provided, while maintaining order
    */
    func titlesForSegmentsAtIndexes(indexes: NSOrderedSet) -> [String] {
        
    }
    
    /**
    Returns the NSString title for a given index
    
    :param: index Index of the requested title
    
    :returns: The NSString title cooresponding to the index.
    */
    func titleForSegmentAtIndex(index: NSInteger) -> String {
        
    }
    
    /**
    Removes the segments at the provided index.
    
    :param: index Index of item to be removed
    */
    func numberOfSegments() -> NSInteger {
        
    }
    
    func removeSegmentsAtIndex(index: Int) {
        
    }
    
    /**
    Removes all the segments
    */
    func removeAllSegments() {
        
    }

}
