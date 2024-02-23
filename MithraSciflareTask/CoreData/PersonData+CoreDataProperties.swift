//
//  PersonData+CoreDataProperties.swift
//  MithraSciflareTask
//
//  Created by Mithra Mohan on 22/02/24.
//
//

import Foundation
import CoreData


extension PersonData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonData> {
        return NSFetchRequest<PersonData>(entityName: "PersonData")
    }

    @NSManaged public var gender: String?
    @NSManaged public var mobileNo: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?

}

extension PersonData : Identifiable {

}
