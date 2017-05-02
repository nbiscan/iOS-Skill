//
//  File.swift
//  MetallumApp
//
//  Created by Five on 28/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import Foundation

extension PageViewAlbumViewController {
    
    func loadAlbum(id : Int64){
        
        let urlString = "http://em.wemakesites.net/album/\(id)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
        
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
            
            if let band = results["band"] as? [String: AnyObject] {
                let band_id = band["id"] as? String
                let band_name = band["band_name"] as? String
                
                if let album = results["album"] as? [String: AnyObject]{
                    let title = album["title"] as? String
                    _ = album["id"] as? String
                    let album_cover = album["album_cover"] as? String
                    let type = album["type"] as? String
                    let releaseDate = album["release date"] as? String
                    let label = album["label"] as? String
                    _ = album["format"] as? String
                    let reviews = album["reviews"] as? String
                    
                    var songsArray : [Song] = []
                    if let songs = album["songs"] as? [[String:AnyObject]]{
                        for song in songs {
                            let name = song["title"] as? String
                            let length = song["length"] as? String
                            var song = Song()
                            song.title = name
                            song.lenght = length
                            songsArray.append(song)
                        }
                        
                        var artistArray : [ArtistStructure] = []
                        if let artists = album["personnel"] as? [[String:AnyObject]]{
                            for artist in artists{
                                let artistName = artist["name"] as? String
                                let instrument = artist["instrument"] as? String
                                let artistId = artist["id"] as? String
                                var artistStruct = ArtistStructure()
                                artistStruct.id = Int64(artistId!)
                                artistStruct.instrument = instrument
                                artistStruct.name = artistName
                                artistArray.append(artistStruct)
                            }
                            
                            var albumStruct = AlbumViewStructure()
                            albumStruct.title = title
                            
                            albumStruct.bandName = band_name
                            albumStruct.bandID = Int64(band_id!)
                            
                            albumStruct.albumCover = album_cover
                            albumStruct.type = type
                            albumStruct.releaseDate = releaseDate
                            albumStruct.label = label
                            albumStruct.reviews = reviews
                            
                            albumStruct.songs = songsArray
                            albumStruct.personnel = artistArray
                            
                            DispatchQueue.main.async {
                                self.views.append(AlbumViewController(album : albumStruct))
                                self.views.append(SongsTableViewController(album : albumStruct))
                                self.views.append(ArtistsViewController(artists : albumStruct.personnel))
                                
                                self.setViewControllers([self.views[0]], direction: .forward, animated: true, completion: nil)
                                self.reloadInputViews()
                            }
                            
                        }

                            
                        }
                        
                    }
                    
                    
            }
            
            
        }
        
        
        
        
    }
    
    
    
}
