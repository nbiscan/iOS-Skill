//
//  ArtistViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 12/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    
    var id:String?
    
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var instrumentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBAction func homeBtn(_ sender: UIButton) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    convenience init (id:String){
        self.init()
        self.id = id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        print(id!)
        loadArtist()
        
    }
    
    
    func loadArtist(){
        let urlString = "http://em.wemakesites.net/artist/\(id!)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
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
        if let data = json?["data"] as? [String: AnyObject] {
            
            let name = data["name"] as? String
            let id = data["id"] as? String
            
            nameLabel.text = name
            print(name!)
            
            if let details = data["details"] as? [String:AnyObject]{
                let photo = details["photo"] as? String
                
                let age = details["age"] as? String
                
                yearsLabel.text = age
                
                //skidanje slike
                
                if let checkedUrl = URL(string: (photo)!) {
                    
                    getDataFromUrl(url: checkedUrl) { (data, response, error)  in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() { () -> Void in
                            self.image.image = UIImage(data: data)
                        }
                    }
                    
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
    
}




