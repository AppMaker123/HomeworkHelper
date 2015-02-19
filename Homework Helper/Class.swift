//
//  Homework_Helper.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/13/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import Foundation
import CoreData

class Class: NSManagedObject {

    @NSManaged var classNumber: String
    @NSManaged var color: AnyObject
    @NSManaged var currentGrade: NSNumber
    @NSManaged var endTime: NSDate
    @NSManaged var fourCharName: String
    @NSManaged var meetingDays: AnyObject
    @NSManaged var name: String
    @NSManaged var notes: String
    @NSManaged var startTime: NSDate
    @NSManaged var teacherName: String
    @NSManaged var teacherRelationship: Teacher
    @NSManaged var assignments: NSOrderedSet

}
