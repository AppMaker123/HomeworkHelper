//
//  Class.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/7/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import Foundation
import CoreData

class Class: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var color: AnyObject
    @NSManaged var teacherName: String
    @NSManaged var startTime: NSDate
    @NSManaged var endTime: NSDate
    @NSManaged var meetingDays: AnyObject
    @NSManaged var fourCharName: String
    @NSManaged var currentGrade: NSNumber
    @NSManaged var classNumber: String
    @NSManaged var notes: String
    @NSManaged var teacherRelationship: Teacher
    @NSManaged var assignmentRelationship: NSOrderedSet

}
