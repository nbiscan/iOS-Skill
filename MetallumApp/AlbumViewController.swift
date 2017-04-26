//
//  FavouriteBandViewController.swift
//  MetallumApp
//
//  Created by Five on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func bandButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    var album : AlbumViewStructure?
    
    convenience init(album : AlbumViewStructure){
        self.init()
        self.album = album
    }
    
    
    override func viewDidLoad() {
        
    }
    
}
