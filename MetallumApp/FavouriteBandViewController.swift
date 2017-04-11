//
//  FavouriteBandViewController.swift
//  MetallumApp
//
//  Created by Five on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class FavouriteBandViewController: UIViewController {

    var dataStore : DataStore?
    var band : Band?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var lyricalThemesLabel: UILabel!
    @IBOutlet weak var yearsActiveLabel: UILabel!
   
    convenience init(dataStore : DataStore, band : Band){
        self.init()
        self.dataStore = dataStore
        self.band = band
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Band info"
        
        nameLabel.text = band?.name
        locationLabel.text = band?.location
        statusLabel.text = band?.status
        genreLabel.text = band?.genre
        lyricalThemesLabel.text = band?.lyricalThemes
        yearsActiveLabel.text = band?.yearsActive
        
    }

}
