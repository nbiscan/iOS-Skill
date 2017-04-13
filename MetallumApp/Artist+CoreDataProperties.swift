//
//  Artist+CoreDataProperties.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist")
    }

    @NSManaged public var id: Int64
    @NSManaged public var instrument: String?
    @NSManaged public var name: String?
    @NSManaged public var years: String?
    @NSManaged public var band: NSSet?

}

// MARK: Generated accessors for band
extension Artist {

    @objc(addBandObject:)
    @NSManaged public func addToBand(_ value: Band)

    @objc(removeBandObject:)
    @NSManaged public func removeFromBand(_ value: Band)

    @objc(addBand:)
    @NSManaged public func addToBand(_ values: NSSet)

    @objc(removeBand:)
    @NSManaged public func removeFromBand(_ values: NSSet)

}
