//
//  BandBioViewController.swift
//  MetallumApp
//
//  Created by Five on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandBioViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var dataStore : DataStore?
    var band : Band?
    
    convenience init(dataStore: DataStore, band : Band){
        self.init()
        self.dataStore = dataStore
        self.band = band
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Band biography"
        textView.text = band?.bio
    }

    
}
