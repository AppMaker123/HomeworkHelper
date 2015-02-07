//
//  Assignment.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/7/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import Foundation
import CoreData

class Assignment: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var dueDate: NSDate
    @NSManaged var grade: NSNumber
    @NSManaged var notes: String
    @NSManaged var classRelationship: Class

}
