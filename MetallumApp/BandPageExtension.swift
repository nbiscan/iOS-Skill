//
//  BandPageExtension.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation

extension BandPageViewController {
    
    func loadBand(id : Int64){
        let urlString = "http://em.wemakesites.net/band/\(id)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
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
            
            let band_id = results["id"] as? String
            let band_name = results["band_name"] as? String
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
                
                
                
                if let discography = results["discography"] as? [[String : AnyObject]]{
                    for album in discography{
                        let title = album["title"] as? String
                        let id = album["id"] as? String
                        let type = album["type"] as? String
                        let year = album["year"] as? String
                        var album = AlbumStructure()
                        album.title = title
                        album.id = Int64(id!)
                        album.type = type
                        album.year = year
                        self.band.album.append(album)
                        
                        
                    }
                    
                    if let lineup = results["current_lineup"] as? [[String : AnyObject]]{
                        for artist in lineup{
                            let name = artist["name"] as? String
                            let id = artist["id"] as? String
                            let instrument = artist["instrument"] as? String
                            let years = artist["years"] as? String
                            var artist = ArtistStructure()
                            artist.name = name
                            artist.id = Int64(id!)
                            artist.years = years
                            artist.instrument = instrument
                            self.band.artist.append(artist)
                            
                            DispatchQueue.main.async {
                                self.band.id = Int64(band_id!)
                                self.band.name = band_name
                                self.band.logoURL = logoURL
                                self.band.photoURL = photoURL
                                self.band.bio = bio
                                self.band.location = location
                                self.band.countryOfOrigin = countryOfOrigin
                                self.band.status = status
                                self.band.formedIn = formedIn
                                self.band.genre = genre
                                self.band.lyricalThemes = lyricalThemes
                                self.band.currentLabel = currentLabel
                                self.band.yearsActive = yearsActive
                            }
                            
                            
                        }
                        
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            self.views.append(BandViewController(band:self.band))
            self.views.append(BioViewController(band:self.band))
            self.views.append(ArtistsViewController(band:self.band))
            self.views.append(AlbumsViewController(band:self.band))
            self.setViewControllers([self.views[0]], direction: .forward, animated: true, completion: nil)
            self.reloadInputViews()
        }
        
        
    }
}
