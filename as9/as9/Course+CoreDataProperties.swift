//
//  Course+CoreDataProperties.swift
//  as9
//
//  Created by Ruchita Iyer on 11/20/23.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var categoryid: Int16
    @NSManaged public var collegeid: Int16
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var programid: Int16
    @NSManaged public var category: Category?
    @NSManaged public var college: College?
    @NSManaged public var program: Program?

}

extension Course : Identifiable {

}
