//
//  BandViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandViewController: UIViewController {
    
    var band:bandStruct?
    var artists:[artistStruct]=[]
    var albums:[albumStruct]=[]
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var yearsActive: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBAction func makeFav(_ sender: UIButton) {
        let dataStore = DataStore()
        var atistsA : [Artist] = []
        for a in artists{
            if let artist = dataStore.insertArtist(id: Int32(a.id!), name: a.name, instrument: a.instrument, years: a.years){
                atistsA.append(artist)
            }
        }
        
        var albumsA : [Album] = []
        for a in albums{
            if let artist = dataStore.insertAlbum(id: Int32(a.id!), title: a.title, year: a.year, type: a.type){
                albumsA.append(artist)
            }
        }
        
        
        dataStore.insertBand(id: Int32((band?.id)!), name: (band?.name)!, location: (band?.location)!, countryOfOrigin: (band?.countryOfOrigin)!, genre: (band?.genre)!, logoURL: (band?.logoURL)!, lyricalThemes: (band?.lyricalThemes)!, photoURL: (band?.photoURL)!, status: (band?.status)!, formedIn: (band?.formedIn)!, currentlabel: (band?.currentLabel)!, yearsActive: (band?.yearsActive)!, bio: (band?.bio!)!, artists: atistsA, albums: albumsA)
    }
    
    @IBAction func home(_ sender: UIButton) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    convenience init (band:bandStruct, artists:[artistStruct], albums:[albumStruct]){
        self.init()
        self.band = band
        self.artists = artists
        self.albums = albums}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(band?.countryOfOrigin)
        
        //skidanje slike
        
        if let checkedUrl = URL(string: (band?.photoURL)!) {
            
            getDataFromUrl(url: checkedUrl) { (data, response, error)  in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { () -> Void in
                    self.image.image = UIImage(data: data)
                }
            }
            
        }
        
        bandName.text = band?.name
        genre.text = band?.genre
        yearsActive.text = band?.yearsActive
        status.text = band?.status
        
        
        
    }
    
    
    //get data from url
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
}
