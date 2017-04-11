//
//  Band+CoreDataProperties.swift
//  MetallumApp
//
//  Created by Five on 10/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation
import CoreData


extension Band {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Band> {
        return NSFetchRequest<Band>(entityName: "Band")
    }

    @NSManaged public var bio: String?
    @NSManaged public var countryOfOrigin: String?
    @NSManaged public var currentLabel: String?
    @NSManaged public var formedIn: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: Int32
    @NSManaged public var location: String?
    @NSManaged public var logoURL: String?
    @NSManaged public var lyricalThemes: String?
    @NSManaged public var name: String?
    @NSManaged public var photoURL: String?
    @NSManaged public var status: String?
    @NSManaged public var yearsActive: String?
    @NSManaged public var album: NSSet?
    @NSManaged public var artist: NSSet?

}

// MARK: Generated accessors for album
extension Band {

    @objc(addAlbumObject:)
    @NSManaged public func addToAlbum(_ value: Album)

    @objc(removeAlbumObject:)
    @NSManaged public func removeFromAlbum(_ value: Album)

    @objc(addAlbum:)
    @NSManaged public func addToAlbum(_ values: NSSet)

    @objc(removeAlbum:)
    @NSManaged public func removeFromAlbum(_ values: NSSet)

}

// MARK: Generated accessors for artist
extension Band {

    @objc(addArtistObject:)
    @NSManaged public func addToArtist(_ value: Artist)

    @objc(removeArtistObject:)
    @NSManaged public func removeFromArtist(_ value: Artist)

    @objc(addArtist:)
    @NSManaged public func addToArtist(_ values: NSSet)

    @objc(removeArtist:)
    @NSManaged public func removeFromArtist(_ values: NSSet)

}
