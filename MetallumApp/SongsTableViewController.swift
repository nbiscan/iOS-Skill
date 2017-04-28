//
//  SongsTableViewController.swift
//  MetallumApp
//
//  Created by Five on 28/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class SongsTableViewController: UITableViewController {
    
    var album : AlbumViewStructure?
    var reuse = "cell"
    
    convenience init(album : AlbumViewStructure){
        self.init()
        self.album = album
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NoImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: reuse)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (album?.songs.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath) as! NoImageCellTableViewCell
        
        cell.textLabel?.text = album?.songs[indexPath.row].title
        cell.detailTextLabel?.text = album?.songs[indexPath.row].lenght
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
}
