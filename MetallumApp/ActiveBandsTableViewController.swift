//
//  ActiveBandsTableViewController.swift
//  MetallumApp
//
//  Created by Five on 02/05/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class ActiveBandsTableViewController: UITableViewController {
    
    var activeBands : [BandProjects] = []
    let cell = "cell"
    
    convenience init(activeBands : [BandProjects]){
        self.init()
        self.activeBands.append(contentsOf: activeBands)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "NoImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeBands.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cell, for: indexPath) as! NoImageCellTableViewCell
        
        let band = activeBands[indexPath.row]        
        cell.textLabel?.text = band.name
        cell.detailTextLabel?.text = ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bandPageViewController = BandPageViewController(id : activeBands[indexPath.row].id!)
        navigationController?.pushViewController(bandPageViewController, animated: true)
    }


}
