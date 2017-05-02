//
//  FavouriteBandViewController.swift
//  MetallumApp
//
//  Created by Five on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    var artist : ArtistViewStructure?
    
    convenience init(artist : ArtistViewStructure){
        self.init()
        self.artist = artist
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.name.text = artist?.name
        self.realName.text = artist?.realName
        self.origin.text = artist?.origin
        self.age.text = artist?.age
        self.gender.text = artist?.gender
       
        if let coverURL = artist?.photoURL {
            if let checkedUrl = URL(string: coverURL) {
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
