//
//  ArtistBiographyViewController.swift
//  MetallumApp
//
//  Created by Five on 02/05/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class ArtistBiographyViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var texView: UITextView!
    
    var artist : ArtistViewStructure?
    
    convenience init(artist : ArtistViewStructure){
        self.init()
        self.artist = artist
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let bio = artist?.bio {
            self.texView.text = bio
        }
        
        if let photoURL = artist?.photoURL {
            if let checkedUrl = URL(string: photoURL) {
                DataStore.getDataFromUrl(url: checkedUrl) { (data, response, error)  in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() { () -> Void in
                        self.imageView.image = UIImage(data: data)
                    }
                }
                
            }
        }
    }

    

   

}
