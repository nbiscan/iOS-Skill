//
//  UpcomingExtension.swift
//  MetallumApp
//
//  Created by Five on 29/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation

extension UpcomingAlbumsTableViewController {
    
    func loadUpcoming(){
        
        let urlString = "http://em.wemakesites.net/albums/upcoming?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
        
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
            
            if let upcoming = results["upcoming_albums"] as? [[String:AnyObject]]{
                for album in upcoming {
                    if let band = album["band"] as? [String:AnyObject]{
                        let bandName = band["name"] as? String
                        let bandID = band["id"] as? String
                        
                        if let a = album["album"] as? [String:AnyObject]{
                            let title = a["title"] as? String
                            let albumID = a["id"] as? String
                            
                            let releaseDate = album["release_date"] as? String
                            
                            var albumStruct = AlbumViewStructure()
                            albumStruct.title = title
                            albumStruct.releaseDate = releaseDate
                            albumStruct.bandName = bandName
                            albumStruct.bandID = Int64(bandID!)
                            albumStruct.albumID = Int64(albumID!)
                            
                            albums.append(albumStruct)
                        }
                        
                    }
                }
            }
            
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
    }

    
}
