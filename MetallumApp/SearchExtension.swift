//
//  SearchExtension.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation

extension SearchTypeViewController {
    
    func searchBands(keyword : String){
        let urlString = "http://em.wemakesites.net/search/band_name/\(keyword)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
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
            self.extractBands(data: data)
        }
        task.resume()
    }
    
    func extractBands(data : Data){
        let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
        //  let dataStore = DataStore()
        if let search = json?["data"] as? [String: AnyObject] {
            if let results = search["search_results"] as? [[String: AnyObject]]{
                for result in results {
                    var b = band()
                    b.id = Int32((result["id"] as? String)!)
                    b.name = result["name"] as? String
                    b.country = result["country"] as? String
                    b.genre = result["genre"] as? String
                    bandResults.append(b)
                }
            }
        }
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
        
    }
    
    func searchAlbums(keyword : String){
        let urlString = "http://em.wemakesites.net/search/album_title/\(keyword)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
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
            self.extractAlbum(data: data)
        }
        task.resume()
    }
    
    func extractAlbum(data : Data){
        let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
        //  let dataStore = DataStore()
        if let search = json?["data"] as? [String: AnyObject] {
            if let results = search["search_results"] as? [[String: AnyObject]]{
                for result in results {
                    var a = album()
                    
                    if let band = result["band"] as? [String:AnyObject]{
                        a.band_id = Int32((band["id"] as? String)!)
                        a.band_name = band["name"] as? String
                        
                        if let album = result["album"] as? [String:AnyObject] {
                            a.id = Int32((album["id"] as? String)!)
                            a.title = album["title"] as? String
                            
                            albumResults.append(a)
                            
                         }
                    }
                    
                }
            }
        }
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
        
    }
    
}
