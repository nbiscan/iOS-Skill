//
//  Album+CoreDataProperties.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation
import CoreData


extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var year: String?
    @NSManaged public var band: Band?

}
