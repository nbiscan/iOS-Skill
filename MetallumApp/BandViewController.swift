//
//  BandViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandViewController: UIViewController {
    
    var id:Int32?
    
    convenience init (id:Int32){
        self.init()
        self.id = id
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
