//
//  BandPageViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    var artists:[artistStruct]=[]
    var albums:[albumStruct] = []
    var band = bandStruct()
    
    var id:String?
    var random:Bool?
    
    
    
    var views : [UIViewController] = []
    
    convenience init(id:String, random:Bool){
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.id = id
        self.random = random
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        self.edgesForExtendedLayout = []
        
        self.loadBands()
        
        
        
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if (viewController is BandViewController){
            return views[1]
        } else if (viewController is ArtistsTableViewController){
            return views[2]
        } else if (viewController is BandBioViewController){
            return views[0]
        } else {
            return views[0]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if (viewController is BandViewController){
            return views[2]
        } else if (viewController is ArtistsTableViewController){
            return views[0]
        } else if (viewController is BandBioViewController){
            return views[1]
        } else {
            return views[0]
        }
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return views.count
    }
    
    // JSON
    
    //get data from url
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    func loadBands(){
        var urlString = ""
        if random == true{
            urlString = "http://em.wemakesites.net/band/random?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
        } else{
            urlString = "http://em.wemakesites.net/band/\(id!)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"}
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
            
       //     let id = results["id"] as? String
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
                
                DispatchQueue.main.async{
                    self.band.id = Int32(self.id!)!
                    self.band.name = name
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
                
                
                
                //        var albumsDB : [Album] = []
                if let discography = results["discography"] as? [[String : AnyObject]]{
                    for album in discography{
                        let title = album["title"] as? String
                        let id = album["id"] as? String
                        let type = album["type"] as? String
                        let year = album["year"] as? String
                        
                        var tmp = albumStruct()
                        tmp.title = title
                        tmp.id = Int32(id!)!
                        tmp.type = type
                        tmp.year = year
                        
                        albums.append(tmp)
                        
                    }
                }
                
                //    var artistsDB : [artistStruct] = []
                if let lineup = results["current_lineup"] as? [[String : AnyObject]]{
                    for artist in lineup{
                        let name = artist["name"] as? String
                        let id = artist["id"] as? String
                        let instrument = artist["instrument"] as? String
                        let years = artist["years"] as? String
                        
                        var tmp = artistStruct()
                        tmp.name = name
                        tmp.id = Int32(id!)!
                        tmp.instrument = instrument
                        tmp.years = years
                        
                        artists.append(tmp)
                    }
                }
            }
        }
        
        print(self.band.name!)

        
        
        views.append(BandViewController(band:band, artists:artists, albums:albums))
        views.append(ArtistsTableViewController(band:band, artists:artists, albums:albums))
        views.append(BandBioViewController(band:band, artists:artists, albums:albums))
        
        
        self.setViewControllers([views[0]], direction: .forward, animated: true, completion: nil)
        
    }
    
    
}
