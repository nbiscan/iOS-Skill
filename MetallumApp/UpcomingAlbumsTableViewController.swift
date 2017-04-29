//
//  UpcomingAlbumsTableViewController.swift
//  MetallumApp
//
//  Created by Five on 29/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class UpcomingAlbumsTableViewController: UITableViewController {
    
    
    var albums : [AlbumViewStructure] = []
    let cell = "cell"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUpcoming()
        tableView.register(UINib(nibName: "NoImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cell, for: indexPath) as! NoImageCellTableViewCell
        
        cell.textLabel?.text = albums[indexPath.row].title
        cell.detailTextLabel?.text = "\(albums[indexPath.row].releaseDate ?? "N/A") - \(albums[indexPath.row].bandName ?? "unkown")"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = PageViewAlbumViewController(id: albums[indexPath.row].albumID!)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    

    
}
