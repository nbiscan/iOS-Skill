//
//  BandAlbumsViewController.swift
//  MetallumApp
//
//  Created by Five on 12/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandAlbumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let c = "cell"
    
    var albums : [Album] = []
    
    convenience init(band : Band){
        self.init()
        let sorted = band.album?.sortedArray(using: [NSSortDescriptor(key: "year", ascending: false , selector: #selector(NSString.compare(_:)))]) as! [Album]
         albums.append(contentsOf: sorted)
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
        // DOTO AFTER IMPLEMENTING ALBUM VIEW
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        let view = PageViewAlbumViewController(id:albums[indexPath.row].id)
        self.navigationController?.pushViewController(view, animated: true)
        
    }

    
    
}
