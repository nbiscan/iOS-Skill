//
//  SearchTypeViewController.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

let identification = "cell"

class SearchTypeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func search(_ sender: UIButton) {
        // let selected = segmentedControl.selectedSegmentIndex
        
        self.bandResults.removeAll()
        self.albumResults.removeAll()
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if (textField.text?.characters.count != 0){
                searchBands(keyword: textField.text!.replacingOccurrences(of: " ", with: "+"))
            }
            break
        default:
            if (textField.text?.characters.count != 0){
                searchAlbums(keyword: textField.text!.replacingOccurrences(of: " ", with: "+"))
            }
            break
        }
        
//        DispatchQueue.main.async(execute: {
//            self.tableView.reloadData()
//        })
        
    }
    
    var bandResults : [band] = []
    var albumResults : [album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.register(UINib(nibName: "NoImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: identification)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            return bandResults.count
        default:
            return albumResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identification, for: indexPath) as! NoImageCellTableViewCell
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let band = bandResults[indexPath.row]
            cell.textLabel?.text = band.name
            cell.detailTextLabel?.text = band.genre
            break
        default:
            let album = albumResults[indexPath.row]
            cell.textLabel?.text = album.title
            cell.detailTextLabel?.text = album.band_name
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TO DO
    }
    
    struct band {
        var name : String?
        var id : Int32?
        var genre : String?
        var country : String?
    }
    
    struct album {
        var band_name : String?
        var band_id : Int32?
        
        var title : String?
        var type : String?
        var release_date : String?
        var id : Int32?
    }
    
    
    
}
