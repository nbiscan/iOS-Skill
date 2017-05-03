//
//  HomeViewController.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func search(_ sender: UIButton) {
        let searchViewController = SearchTypeViewController()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    @IBAction func ripAction(_ sender: UIButton) {
        let view = RIPTableViewController()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    @IBAction func upcomingAlbums(_ sender: UIButton) {
        let view = UpcomingAlbumsTableViewController()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    @IBAction func randomBand(_ sender: UIButton) {
        let view = RandomBandPageViewController()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    @IBAction func savedBands(_ sender: UIButton) {
        let savedBands = FavouriteBandsViewController()
        self.navigationController?.pushViewController(savedBands, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage(named: "Metallum_logo")
    }
    
}
