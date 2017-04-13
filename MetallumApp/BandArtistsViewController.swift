//
//  BandArtistsViewController.swift
//  MetallumApp
//
//  Created by Five on 12/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit



class BandArtistsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cell = "cell"
    
    var artists : [Artist] = []
    
    convenience init( band : Band ){
        self.init()
        let a = band.artist?.allObjects as! [Artist]
        self.artists.append(contentsOf: a)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.register(UINib(nibName: "NoImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cell, for: indexPath) as! NoImageCellTableViewCell
        
        let artist = artists[indexPath.row]
        
        cell.textLabel?.text = artist.name?.replacingOccurrences(of: "&quot;", with: "")
        cell.detailTextLabel?.text = artist.instrument?.replacingOccurrences(of: "&nbsp;", with: "")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO NAKON ARTIST VIEW - a
        self.tableView.deselectRow(at: indexPath, animated: false)
    }

    
}
