//
//  DataStoreArtistExtension.swift
//  MetallumApp
//
//  Created by Five on 10/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation
import CoreData

extension DataStore {
    
    
    func insertBand(id : Int64,
                    name : String?,
                    location : String?,
                    countryOfOrigin: String?,
                    genre: String?,
                    logoURL : String?,
                    lyricalThemes:String?,
                    photoURL : String?,
                    status : String?,
                    formedIn : String?,
                    currentlabel : String?,
                    yearsActive : String?,
                    bio : String?,
                    artists : [Artist],
                    albums : [Album]
        ) {
        
        if let band = NSEntityDescription.insertNewObject(forEntityName: "Band", into: managedObjectContext) as? Band {
            band.name = name
            band.countryOfOrigin = countryOfOrigin
            band.location = location
            band.genre = genre
            band.logoURL = logoURL
            band.photoURL = photoURL
            band.lyricalThemes = lyricalThemes
            band.status = status
            band.formedIn = formedIn
            band.yearsActive = yearsActive
            band.currentLabel = currentlabel
            band.bio = bio
            band.id = id
            
            for album in albums {
                band.addToAlbum(album)
            }
            
            for artist in artists {
                band.addToArtist(artist)
                
                do {
                    try managedObjectContext.save()
                } catch  {
                    print(error)
                }
            }
        }
    }
    
    func insertArtist(id : Int64,
                      name : String?,
                      instrument : String?,
                      years : String?) -> Artist? {
        
        if let artist = NSEntityDescription.insertNewObject(forEntityName: "Artist", into: managedObjectContext) as? Artist {
        
            artist.name = name
            artist.years = years
            artist.id = id
            artist.instrument = instrument
            
            do {
                try managedObjectContext.save()
            } catch  {
                print(error)
            }
            
            return artist
            
        }
        return nil
    }
    
    func insertAlbum( id : Int64,
                      title : String?,
                      year : String?,
                      type : String?) -> Album? {
        
        if let album = NSEntityDescription.insertNewObject(forEntityName: "Album", into: managedObjectContext) as? Album {
            
            album.title = title
            album.id = id
            album.type = type
            album.year = year
            
            // completion(album)
            
            do {
                try managedObjectContext.save()
            } catch  {
                print(error)
            }
            
            return album
        }
        return nil
    }
    
    
    func printDatabaseStatistics() {
        do {
            let count = try managedObjectContext.count(for: NSFetchRequest(entityName: "Band"))
            print("\(count) Bands")
        }catch _ {}
    }
    
    func deleteBand(band : Band){
        managedObjectContext.delete(band)
        self.saveContext()
    }
    
    func deleteEverything(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Band")
        do{
            let items = try managedObjectContext.fetch(request) as! [NSManagedObject]
            
            for item in items {
                managedObjectContext.delete(item)
            }
            
        } catch _ {}
    }
    
    static func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
}
