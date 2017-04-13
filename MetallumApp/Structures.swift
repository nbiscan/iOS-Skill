//
//  Structures.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation

struct BandStructure {
    var bio: String?
    var countryOfOrigin: String?
    var currentLabel: String?
    var formedIn: String?
    var genre: String?
    var id: Int64?
    var location: String?
    var logoURL: String?
    var lyricalThemes: String?
    var name: String?
    var photoURL: String?
    var status: String?
    var yearsActive: String?
    var album: [AlbumStructure] = []
    var artist: [ArtistStructure] = []
}


struct AlbumStructure{
    var id: Int64?
    var title: String?
    var type: String?
    var year: String?
}

struct ArtistStructure{
    var id: Int64?
    var instrument: String?
    var name: String?
    var years: String?
}
