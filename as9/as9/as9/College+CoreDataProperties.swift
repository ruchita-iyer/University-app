//
//  College+CoreDataProperties.swift
//  as9
//
//  Created by Ruchita Iyer on 11/21/23.
//
//

import Foundation
import CoreData


extension College {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<College> {
        return NSFetchRequest<College>(entityName: "College")
    }

    @NSManaged public var address: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var images: Data?
    @NSManaged public var course: NSSet?
    @NSManaged public var program: NSSet?

}

// MARK: Generated accessors for course
extension College {

    @objc(addCourseObject:)
    @NSManaged public func addToCourse(_ value: Course)

    @objc(removeCourseObject:)
    @NSManaged public func removeFromCourse(_ value: Course)

    @objc(addCourse:)
    @NSManaged public func addToCourse(_ values: NSSet)

    @objc(removeCourse:)
    @NSManaged public func removeFromCourse(_ values: NSSet)

}

// MARK: Generated accessors for program
extension College {

    @objc(addProgramObject:)
    @NSManaged public func addToProgram(_ value: Program)

    @objc(removeProgramObject:)
    @NSManaged public func removeFromProgram(_ value: Program)

    @objc(addProgram:)
    @NSManaged public func addToProgram(_ values: NSSet)

    @objc(removeProgram:)
    @NSManaged public func removeFromProgram(_ values: NSSet)

}

extension College : Identifiable {

}
