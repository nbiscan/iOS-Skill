//
//  RIPTableViewController.swift
//  MetallumApp
//
//  Created by Five on 03/05/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class RIPTableViewController: UITableViewController {
    
    let cell = "cell"
    var deceased : [DeceasedArtist] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "NoImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
        
        loadDeceasedArtists()
        self.title = "Deceased artists"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deceased.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cell, for: indexPath) as! NoImageCellTableViewCell
        
        let artist = deceased[indexPath.row]
        cell.textLabel?.text = artist.name
        cell.detailTextLabel?.text = artist.causeOfDeath
        
        return cell    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = ArtistPageViewController(id: deceased[indexPath.row].id!)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    struct DeceasedArtist {
        
        var name : String?
        var id : Int64?
        var causeOfDeath : String?
        
    }

    
}
