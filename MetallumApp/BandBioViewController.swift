//
//  BandBioViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandBioViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    var band:bandStruct?
    var artists:[artistStruct]=[]
    var albums:[albumStruct]=[]

    
    convenience init (band:bandStruct, artists:[artistStruct], albums:[albumStruct]){
        self.init()
        self.band = band
        self.artists = artists
        self.albums = albums
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Band biography"
        
        
        //skidanje slike
        
        if let checkedUrl = URL(string: (band?.photoURL)!) {
            
            getDataFromUrl(url: checkedUrl) { (data, response, error)  in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { () -> Void in
                    self.imageView.image = UIImage(data: data)
                }
            }
            
        }
        
        textView.text = band?.bio

        
    }
    

    
    //get data from url
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    
}



