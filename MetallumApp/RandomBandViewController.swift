//
//  FavouriteBandViewController.swift
//  MetallumApp
//
//  Created by Five on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class RandomBandViewController: UIViewController {
    
    var dataStore : DataStore = (UIApplication.shared.delegate as! AppDelegate).dataStore
    var band : BandStructure?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var lyricalThemesLabel: UILabel!
    @IBOutlet weak var yearsActiveLabel: UILabel!
    @IBOutlet weak var removeButtonOutlet: UIButton!
    
    @IBAction func newRandom(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func removeButton(_ sender: UIButton) {
        if (removeButtonOutlet.currentTitle == "Remove"){
            dataStore.deleteBand(with: (band?.id!)!)
            removeButtonOutlet.setTitle("Save band", for: .normal)
        } else {
            dataStore.insertBand(band: band!)
            removeButtonOutlet.setTitle("Remove", for: .normal)
        }
    }
    
    convenience init(band : BandStructure){
        self.init()
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
        
        activityIndicator.alpha = 0
        
        removeButtonOutlet.setTitle("", for: .normal)
        
        if (dataStore.checkIfBandExists(id: (band?.id)!)){
            removeButtonOutlet.setTitle("Remove", for: .normal)
        } else {
            removeButtonOutlet.setTitle("Save band", for: .normal)
        }
        
        if let logoURL = band?.logoURL {
            if let checkedUrl = URL(string: logoURL) {
                
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
