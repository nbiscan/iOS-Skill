//
//  HomeViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var getUpcomingBtn: UIButton!
    @IBOutlet weak var randomBandBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    var dataStore:DataStore?
    
    convenience init (dataStore: DataStore){
        self.init()
        self.dataStore = dataStore
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = #imageLiteral(resourceName: "bcgrd")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.tapFunction))

        
        getUpcomingBtn.isUserInteractionEnabled = true
        getUpcomingBtn.addGestureRecognizer(tap)
        
    }
    
    
    
    func tapFunction(){
        let newViewController = UpcomingTableViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
}
