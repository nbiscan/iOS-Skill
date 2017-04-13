//
//  ArtistsTableViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 12/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class ArtistsTableViewController: UITableViewController {
    
    var artists:[Artist] = []
    
    var id:String?
    
    convenience init (id:String) {
        self.init()
        self.id = id
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadArtists()

        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        title = "Artists in band"
        
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor.black
        
        
    }
    
    
    func loadArtists(){
        let urlString = "http://em.wemakesites.net/band/\(id!)?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let data = data, let _ = response else {
                // handle error
                return
            }
            self.extract_json(data)
        }
        task.resume()
        
    }
    
    private func extract_json(_ data : Data){
        let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
        //  let dataStore = DataStore()
        if let results = json?["data"] as? [String: AnyObject] {
            
            
            if let lineup = results["current_lineup"] as? [[String : AnyObject]]{
                for artist in lineup{
                    let name = artist["name"] as? String
                    let id = artist["id"] as? String
                    
                    let tmp = Artist(name:name!, id:id!)
                    artists.append(tmp)
                    
                }
            }
        }
        
        DispatchQueue.main.async(execute: {self.tableView.reloadData()})
    }
    
    
    
    
    // TABLE VIEW
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.red

        
        cell.textLabel?.text = artists[indexPath.row].name
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id="tmp"
        let secondVC = ArtistViewController(id:id)
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    struct Artist{
        var name:String
        var id:String
    }
    
}
