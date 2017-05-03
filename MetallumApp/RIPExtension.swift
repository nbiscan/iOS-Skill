//
//  RIPExtension.swift
//  MetallumApp
//
//  Created by Five on 03/05/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation

extension RIPTableViewController {
    
    
    func loadDeceasedArtists(){
        let urlString = "http://em.wemakesites.net/artists/deceased?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
        
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
    
    
    private func extract_json(_ data : Data){
        let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
        //  let dataStore = DataStore()
        if let results = json?["data"] as? [String: AnyObject] {
            if let deceased = results["deceased"] as? [[String:AnyObject]]{
                for artist in deceased {
                    var deceasedArtist = DeceasedArtist()
                    deceasedArtist.name = artist["name"] as? String
                    deceasedArtist.causeOfDeath = artist["date_of_death"] as? String
                    let id = artist["id"] as? String
                    deceasedArtist.id = Int64(id!)
                    
                    self.deceased.append(deceasedArtist)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}
