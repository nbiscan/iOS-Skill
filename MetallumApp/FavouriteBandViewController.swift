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
    
    convenience init(dataStore : DataStore){
        self.init()
        self.dataStore = dataStore
        self.navigationItem.title = "band"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
