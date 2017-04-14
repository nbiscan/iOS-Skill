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
    
    
    func insertBand(band : BandStructure
        ) {
        
        if let newBand = NSEntityDescription.insertNewObject(forEntityName: "Band", into: managedObjectContext) as? Band {
            newBand.name = band.name
            newBand.countryOfOrigin = band.countryOfOrigin
            newBand.location = band.location
            newBand.genre = band.genre
            newBand.logoURL = band.logoURL
            newBand.photoURL = band.photoURL
            newBand.lyricalThemes = band.lyricalThemes
            newBand.status = band.status
            newBand.formedIn = band.formedIn
            newBand.yearsActive = band.yearsActive
            newBand.currentLabel = band.currentLabel
            newBand.bio = band.bio
            newBand.id = band.id!
            
            for album in band.album {
                if let a = self.insertAlbum(album: album){
                    newBand.addToAlbum(a)
                }
            }
            
            for artist in band.artist {
                if let a = self.insertArtist(artist: artist){
                    newBand.addToArtist(a)
                }
            }
            
            saveContext()
        }
    }
    
    func insertArtist(artist : ArtistStructure) -> Artist? {
        
        if let newArtist = NSEntityDescription.insertNewObject(forEntityName: "Artist", into: managedObjectContext) as? Artist {
            
            newArtist.name = artist.name
            newArtist.years = artist.years
            newArtist.id = artist.id!
            newArtist.instrument = artist.instrument
            
            do {
                try managedObjectContext.save()
            } catch  {
                print(error)
            }
            
            return newArtist
            
        }
        return nil
    }
    
    func insertAlbum( album : AlbumStructure) -> Album? {
        
        if let newAlbum = NSEntityDescription.insertNewObject(forEntityName: "Album", into: managedObjectContext) as? Album {
            
            newAlbum.title = album.title
            newAlbum.id = album.id!
            newAlbum.type = album.type
            newAlbum.year = album.year
            
            do {
                try managedObjectContext.save()
            } catch  {
                print(error)
            }
            
            return newAlbum
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
