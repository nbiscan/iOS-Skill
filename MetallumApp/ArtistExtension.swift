//
//  ArtistExtension.swift
//  MetallumApp
//
//  Created by Five on 02/05/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation
import UIKit

extension ArtistPageViewController {
    
    func loadArtist(id : Int64){
        
        let urlString = "http://em.wemakesites.net/artist/\(id)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
        
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
            
            var artist = ArtistViewStructure()
            
            artist.name = results["name"] as? String
            let _ = results["id"] as? String
            
            if let details = results["details"] as? [String:AnyObject] {
                artist.bio = details["bio"] as? String
                artist.photoURL = details["photo"] as? String
                
                artist.realName = details["real/full name"] as? String
                artist.age = details["age"] as? String
                artist.origin = details["place of origin"] as? String
                artist.gender = details["gender"] as? String
                
                if let bands = details["bands"] as? [String:AnyObject]{
                    
                    if let active = bands["active"] as? [[String:AnyObject]]{
                        for band in active {
                            let bandName = band["name"] as? String
                            let bandID = band["id"] as? String
                            var bandProject = BandProjects()
                            bandProject.name = bandName
                            bandProject.id = Int64(bandID!)
                            artist.activeBands.append(bandProject)
                        }
                    }
                    
                    if let past = bands["past"] as? [[String:AnyObject]]{
                        for band in past {
                            let bandName = band["name"] as? String
                            let bandID = band["id"] as? String
                            var bandProject = BandProjects()
                            bandProject.name = bandName
                            bandProject.id = Int64(bandID!)
                            artist.pastBands.append(bandProject)
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.views.append(ArtistViewController(artist: artist))
                self.views.append(ArtistBiographyViewController(artist: artist))
                self.views.append(ActiveBandsTableViewController(activeBands: artist.activeBands))
                self.views.append(PastBandsTableViewController(pastBands: artist.pastBands))
                self.setViewControllers([self.views[0]], direction: .forward, animated: true, completion: nil)
                self.reloadInputViews()
                
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Artist info not available!", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
}
