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
    
    @IBOutlet weak var buttonBandName: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let bandPageViewController = BandPageViewController(id : (album?.bandID)!, random : false)
        navigationController?.pushViewController(bandPageViewController, animated: true)
    }
    
    // @IBAction func bandButton(_ sender: UIButton) {
     //   let bandPageViewController = BandPageViewController(id : (album?.bandID)!, random : false)
      //  navigationController?.pushViewController(bandPageViewController, animated: true)
    // }
    
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
        
        super.viewDidLoad()
        
        titleLabel.text = album?.title
        
        buttonBandName.setTitle(album?.bandName, for: .normal)
        
        releaseDateLabel.text = album?.releaseDate
        label.text = album?.label
        formatLabel.text = album?.type
        reviewsLabel.text = album?.reviews
        
        if let coverURL = album?.albumCover {
            if let checkedUrl = URL(string: coverURL) {
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
