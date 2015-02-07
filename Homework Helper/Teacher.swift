//
//  Teacher.swift
//  Homework Helper
//
//  Created by Cory Ginsberg on 2/7/15.
//  Copyright (c) 2015 Boiling Point Development. All rights reserved.
//

import Foundation
import CoreData

class Teacher: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var notes: String
    @NSManaged var email: String
    @NSManaged var classRelationship: NSSet

}
