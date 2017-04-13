//
//  BandAlbumsViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandAlbumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let c = "cell"
    
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
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.register(UINib(nibName: "NoImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: c)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.c, for: indexPath) as! NoImageCellTableViewCell
        
        let album = albums[indexPath.row]
        
        cell.textLabel?.text = album.title
        cell.detailTextLabel?.text = album.year
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = AlbumViewController(albumid: albums[indexPath.row].id!)
        navigationController?.pushViewController(secondVC, animated: true)

    }
    
    
    
}

