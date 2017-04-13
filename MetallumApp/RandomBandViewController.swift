//
//  RandomBandViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 12/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class RandomBandViewController: UIViewController {
    @IBOutlet weak var bandnameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearsactiveLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var saveFavoriteBtn: UIButton!
    @IBAction func refesh(_ sender: UIButton) {
        loadRandomBand()
        
    }
    
    var artistId:String?
    
    var id:String?
    var name:String?
    var location:String?
    var countryOfOrigin:String?
    var genre: String?
    var logoURL : String?
    var lyricalThemes:String?
    var photoURL : String?
    var status : String?
    var formedIn : String?
    var currentlabel : String?
    var yearsActive : String?
    var bio : String?
    
    let datastore = DataStore()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRandomBand()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RandomBandViewController.tapFunction))
        let fav = UITapGestureRecognizer(target: self, action: #selector(RandomBandViewController.favFunc))
        
        
        bandnameLabel.isUserInteractionEnabled = true
        bandnameLabel.addGestureRecognizer(tap)
        
        saveFavoriteBtn.addGestureRecognizer(fav)
        
        
    }
    
    func favFunc(){
        datastore.insertBand(id : Int32(id!)!,
                             name : name!,
                             location : location!,
                             countryOfOrigin: countryOfOrigin!,
                             genre: genre!,
                             logoURL : logoURL!,
                             lyricalThemes:lyricalThemes!,
                             photoURL : photoURL!,
                             status : status!,
                             formedIn : formedIn!,
                             currentlabel : currentlabel!,
                             yearsActive : yearsActive!,
                             bio : bio!)
        
        datastore.saveContext()
        print("saved to DB")
        
    }
    
    
    
    func loadRandomBand(){
        let urlString = "http://em.wemakesites.net/band/random?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
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
            
            let idJ = results["id"] as? String
            let nameJ = results["band_name"] as? String
            let logoURLJ = results["logo"] as? String
            let photoURLJ = results["photo"] as? String
            let bioJ = results["bio"] as? String
            
            
            DispatchQueue.main.async{
                self.id = idJ
                self.name = nameJ
                self.logoURL = logoURLJ
                self.photoURL = photoURLJ
                self.bio = bioJ
                self.bandnameLabel.text = nameJ
            }
            
            
            
            //skidanje slike
            
            if let checkedUrl = URL(string: (logoURLJ)!) {
                
                getDataFromUrl(url: checkedUrl) { (data, response, error)  in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() { () -> Void in
                        self.image.image = UIImage(data: data)
                    }
                }
                
            }
            
            
            
            if let details = results["details"] as? [String:AnyObject]{
                let locationJ = details["location"] as? String
                let countryOfOriginJ = details["country of origin"] as? String
                let statusJ = details["status"] as? String
                let formedInJ = details["formed in"] as? String
                let genreJ = details["genre"] as? String
                let lyricalThemesJ = details["lyrical themes"] as? String
                let currentLabelJ = details["current label"] as? String
                let yearsActiveJ = details["years active"] as? String
                
                DispatchQueue.main.async
                    {
                        self.location = locationJ
                        self.countryOfOrigin = countryOfOriginJ
                        self.status = statusJ
                        self.formedIn = formedInJ
                        self.genre = genreJ
                        self.lyricalThemes = lyricalThemesJ
                        self.currentlabel = currentLabelJ
                        self.yearsActive = yearsActiveJ
                        
                        
                        self.genreLabel.text = genreJ
                        self.statusLabel.text = statusJ
                        self.yearsactiveLabel.text = yearsActiveJ
                }
                
                var albums : [Album] = []
                if let discography = results["discography"] as? [[String : AnyObject]]{
                    for album in discography{
                        let titleJ = album["title"] as? String
                        let idJ = album["id"] as? String
                        let typeJ = album["type"] as? String
                        let yearJ = album["year"] as? String
                        
                    }
                    
                }
            }
            
            
            
            
            
            
            var artists : [Artist] = []
            if let lineup = results["current_lineup"] as? [[String : AnyObject]]{
                for artist in lineup{
                    let nameJ = artist["name"] as? String
                    let idJ = artist["id"] as? String
                    let instrumentJ = artist["instrument"] as? String
                    let yearsJ = artist["years"] as? String
                }
            }
        }
        
    }
    
    
    //get data from url
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func tapFunction(){
        print("finish this")
        
    }
    
}
