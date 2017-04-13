//
//  ArtistsTableViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 12/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class ArtistsTableViewController: UITableViewController {
    
    var band:bandStruct?
    var artists:[artistStruct]=[]
    var albums:[albumStruct]=[]
    
    convenience init (band:bandStruct, artists:[artistStruct], albums:[albumStruct]){
        self.init()
        self.band = band
        self.artists = artists
        self.albums = albums
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NoImageCellTableViewCell", bundle:nil), forCellReuseIdentifier: "reuseIdentifier")
        title = "Artists in band"
        
        
        
    }
    

    
    
    
    // TABLE VIEW
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? NoImageCellTableViewCell

        
        cell?.textLabel?.text = artists[indexPath.row].name
        cell?.detailTextLabel?.text = nil
        
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id="tmp"
        let secondVC = ArtistViewController(id:id)
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    //
    
    struct Artist{
        var name:String
        var id:String
    }
    
}
