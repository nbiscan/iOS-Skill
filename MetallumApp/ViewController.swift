//
//  ViewController.swift
//  MetallumApp
//
//  Created by Five on 10/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataStore = DataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataStore.deleteEverything()
        dataStore.printDatabaseStatistics()
        loadReviews()
    }
    
    
    func loadReviews(){
        let urlString = "http://em.wemakesites.net/band/186?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let data = data, let _ = response else {
                // handle error
                return
            }
            self.extract_json(data)
        }
        task.resume()
    }
    
    //extracts data from JSON
    private func extract_json(_ data : Data){
        let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
       //  let dataStore = DataStore()
        if let results = json?["data"] as? [String: AnyObject] {
            
            let id = results["id"] as? String
            let name = results["band_name"] as? String
            let logoURL = results["logo"] as? String
            let photoURL = results["photo"] as? String
            let bio = results["bio"] as? String
            
            if let details = results["details"] as? [String:AnyObject]{
                let location = details["location"] as? String
                let countryOfOrigin = details["country of origin"] as? String
                let status = details["status"] as? String
                let formedIn = details["formed in"] as? String
                let genre = details["genre"] as? String
                let lyricalThemes = details["lyrical themes"] as? String
                let currentLabel = details["current label"] as? String
                let yearsActive = details["years active"] as? String
                
//                dataStore.insertBand(id: Int32(id!)!, name: name!, location: location!, countryOfOrigin: countryOfOrigin!, genre: genre!, logoURL: logoURL!, lyricalThemes: lyricalThemes!, photoURL: photoURL!, status: status!, formedIn: formedIn!, currentlabel: currentLabel!, yearsActive: yearsActive!, bio: bio!)
//                
//                dataStore.printDatabaseStatistics()
            }
            
            
        }
    }


    
}

