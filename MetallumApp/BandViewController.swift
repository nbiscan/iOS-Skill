//
//  BandViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandViewController: UIViewController {
    
    var ID:String?
    
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
    
    
    @IBOutlet weak var logoIV: UIImageView!
    @IBOutlet weak var bandNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var yearsActiveLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var makeFavoriteBtn: UIButton!
    
    convenience init (ID:String){
        self.init()
        self.ID = ID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBands()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(BandViewController.tapFunction))
        let fav = UITapGestureRecognizer(target: self, action: #selector(BandViewController.favFunc))
        
        
        
        homeBtn.isUserInteractionEnabled = true
        homeBtn.addGestureRecognizer(tap)
        
        makeFavoriteBtn.isUserInteractionEnabled = true
        makeFavoriteBtn.addGestureRecognizer(fav)
        
        
        
    }
    
    func tapFunction(){
        _ = navigationController?.popToRootViewController(animated: true)
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
    
    //get data from url
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    func loadBands(){
        let urlString = "http://em.wemakesites.net/band/\(ID!)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
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
        if let results = json?["data"] as? [String: AnyObject] {
            
            let idJ = results["id"] as? String
            let nameJ = results["band_name"] as? String
            let logoURLJ = results["logo"] as? String
            let photoURLJ = results["photo"] as? String
            let bioJ = results["bio"] as? String
            
            
            bandNameLabel.text = nameJ
            self.title = nameJ
            
            id = idJ
            name = nameJ
            logoURL = logoURLJ
            photoURL = photoURLJ
            bio = bioJ
            
            
            
            //skidanje slike
            
            if let checkedUrl = URL(string: (logoURL)!) {
                
                getDataFromUrl(url: checkedUrl) { (data, response, error)  in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() { () -> Void in
                        self.logoIV.image = UIImage(data: data)
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
                
                location = locationJ
                countryOfOrigin = countryOfOriginJ
                status = statusJ
                formedIn = formedInJ
                genre = genreJ
                lyricalThemes = lyricalThemesJ
                currentlabel = currentLabelJ
                yearsActive = yearsActiveJ
                
                yearsActiveLabel.text = yearsActiveJ
                typeLabel.text = genreJ
                statusLabel.text = statusJ
                
                var albums : [Album] = []
                if let discography = results["discography"] as? [[String : AnyObject]]{
                    for album in discography{
                        let title = album["title"] as? String
                        let id = album["id"] as? String
                        let type = album["type"] as? String
                        let year = album["year"] as? String
                        
                    }
                    
                }
            }
            
            var artists : [Artist] = []
            if let lineup = results["current_lineup"] as? [[String : AnyObject]]{
                for artist in lineup{
                    let name = artist["name"] as? String
                    let id = artist["id"] as? String
                    let instrument = artist["instrument"] as? String
                    let years = artist["years"] as? String
                }
            }
        }
        
    }
}
