//
//  BandBioViewController.swift
//  MetallumApp
//
//  Created by Five on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandBioViewController: UIViewController {

    var dataStore : DataStore?
    
    convenience init(dataStore: DataStore){
        self.init()
        self.dataStore = dataStore
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "bio"
        // Do any additional setup after loading the view.
    }

    
}
