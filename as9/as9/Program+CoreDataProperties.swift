//
//  Program+CoreDataProperties.swift
//  as9
//
//  Created by Ruchita Iyer on 11/20/23.
//
//

import Foundation
import CoreData


extension Program {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Program> {
        return NSFetchRequest<Program>(entityName: "Program")
    }

    @NSManaged public var collegeid: Int16
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var college: College?
    @NSManaged public var course: NSSet?

}

// MARK: Generated accessors for course
extension Program {

    @objc(addCourseObject:)
    @NSManaged public func addToCourse(_ value: Course)

    @objc(removeCourseObject:)
    @NSManaged public func removeFromCourse(_ value: Course)

    @objc(addCourse:)
    @NSManaged public func addToCourse(_ values: NSSet)

    @objc(removeCourse:)
    @NSManaged public func removeFromCourse(_ values: NSSet)

}

extension Program : Identifiable {

}
