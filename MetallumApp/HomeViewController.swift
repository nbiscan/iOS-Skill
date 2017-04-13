//
//  HomeViewController.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var dataStore : DataStore?
    
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func search(_ sender: UIButton) {
        let searchViewController = SearchTypeViewController()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    @IBAction func upcomingAlbums(_ sender: UIButton) {
    }
    
    
    @IBAction func randomBand(_ sender: UIButton) {
    }
    
    
    @IBAction func savedBands(_ sender: UIButton) {
        let savedBands = FavouriteBandsViewController()
        self.navigationController?.pushViewController(savedBands, animated: true)
    }
    
    
    convenience init(dataStore: DataStore){
        self.init()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage(named: "Metallum_logo")
    }


}
