//
//  AlbumViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var bandLabel: UILabel!
    @IBAction func homeBtn(_ sender: UIButton) {
        _ = navigationController?.popToRootViewController(animated: true)

        
    }
    
    
    var actualAlbum:album?
    var actualBand:band?
    
    var bandID:String?
    var albumid:Int32?
    
    convenience init(albumid: Int32){
        self.init()
        self.albumid = albumid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUpcomingAlbums()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AlbumViewController.tapFunction))

        bandLabel.isUserInteractionEnabled = true
        bandLabel.addGestureRecognizer(tap)
        
        

    }
    
    
    func loadUpcomingAlbums(){
        let urlString = "http://em.wemakesites.net/album/\(albumid!)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
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
        if let a = json?["data"] as? [String: AnyObject] {
            if let first = a["album"] as? [String:AnyObject]{
                
                let title = first["title"] as? String
                let id = first["id"] as? String
                let type = first["type"] as? String
                let albumCover = first["album_cover"] as? String
                let format = first["format"] as? String
                
                
                if let first1 = a["band"] as? [String:AnyObject]{
                    let bandName = first1["band_name"] as? String
                    let bandId = first1["id"] as? String
                    
                    DispatchQueue.main.async(execute: {
                        self.bandID = bandId
                        self.actualBand = band(id: Int32(bandId!), name: bandName)
                        self.actualAlbum = album(id: Int32(id!), type:type, title: title, albumCover: albumCover, format: format)
                        self.title = title
                        
                        self.bandLabel.text = bandName
                        self.bandLabel.textColor = UIColor.purple
                        self.typeLabel.text = type
                        self.titleLabel.text = title
                        self.formatLabel.text = format
                    })
                }
                
                //skidanje slike
                
                if let checkedUrl = URL(string: (albumCover)!) {
                    
                    getDataFromUrl(url: checkedUrl) { (data, response, error)  in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() { () -> Void in
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                    
                }
                
                
            }
            
            

        }
        

    }
    
    struct album {
        var id:Int32?
        var type:String?
        var title:String?
        var albumCover:String?
        var format:String?
    }
    
    struct band{
        var id:Int32?
        var name:String?
    }
    
    //get data from url
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func tapFunction(sender:UITapGestureRecognizer) {
        let thirdViewController = BandPageViewController(id: bandID!, random:false)
        navigationController?.pushViewController(thirdViewController, animated: true)
    }

}
