//
//  File.swift
//  MetallumApp
//
//  Created by Natko Biscan on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation

struct bandStruct{
    
    public var bio: String?
    public var countryOfOrigin: String?
    public var currentLabel: String?
    public var formedIn: String?
    public var genre: String?
    public var id: Int32?
    public var location: String?
    public var logoURL: String?
    public var lyricalThemes: String?
    public var name: String?
    public var photoURL: String?
    public var status: String?
    public var yearsActive: String?
    
    public var albumsStructs:[albumStruct]
    public var artistsStructs:[artistStruct]
}

struct albumStruct {
    
    public var id: Int32?
    public var title: String?
    public var type: String?
    public var year: String?
    
}

struct artistStruct {
    
     public var id: Int32?
     public var instrument: String?
     public var name: String?
     public var years: String?

}

