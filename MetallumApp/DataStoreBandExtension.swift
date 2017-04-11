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
    
    
    func insertBand(id : Int32,
                    name : String,
                    location : String,
                    countryOfOrigin: String,
                    genre: String,
                    logoURL : String,
                    lyricalThemes:String,
                    photoURL : String,
                    status : String,
                    formedIn : String,
                    currentlabel : String,
                    yearsActive : String,
                    bio : String // ,
                    // artists : [Artist],
                    // albums : [Album]
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
            
            do {
                try managedObjectContext.save()
            } catch  {
                print(error)
            }
            // saveContext()
            // band.artist?.addingObjects(from: artists)
            // band.album?.addingObjects(from: albums)
        }
    }
    
    
    func printDatabaseStatistics() {
        do {
            let count = try managedObjectContext.count(for: NSFetchRequest(entityName: "Band"))
            print("\(count) Bands")
        }catch _ {}
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
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
}
