//
//  UpcomingTableViewController.swift
//  MetallumApp
//
//  Created by Natko Biscan on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class UpcomingTableViewController: UITableViewController {
    
    var actualAlbum:[upcomingAlbum] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUpcomingAlbums()
        
        
        tableView.register(UINib(nibName: "NoImageCellTableViewCell", bundle:nil), forCellReuseIdentifier: "reuseIdentifier")
        title = "Upcoming albums"
        
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor.black
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actualAlbum.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! NoImageCellTableViewCell
        
        if let name = actualAlbum[indexPath.row].name {
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = actualAlbum[indexPath.row].title
        } else{
            cell.textLabel?.text = "N/A"
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondVC = AlbumViewController(albumid: actualAlbum[indexPath.row].id!)
        navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    
    
    func loadUpcomingAlbums(){
        let urlString = "http://em.wemakesites.net/albums/upcoming?api_key=c7005c75-a41c-474f-89c4-6ae11c1bbd19"
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
        if let first = json?["data"] as? [String: AnyObject] {
            if let results = first["upcoming_albums"] as? [AnyObject]{
                for r in results{
                    if let bands = r["band"] as? [String: AnyObject]{
                        let name = bands["name"] as? String
                        if let albums = r["album"] as? [String: AnyObject]{
                            let title = albums["title"] as? String
                            let id = albums["id"] as? String
                            
                            let tmpAlbum = upcomingAlbum(id: Int32(id!), name: name, title:title)
                            actualAlbum.append(tmpAlbum)
                            
                        }
                        
                    }
                }
            }
        }
        
        DispatchQueue.main.async(execute: {self.tableView.reloadData()})
    }
    
    //get data from url
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    struct upcomingAlbum {
        var id:Int32?
        var name:String?
        var title:String?
        
        
    }
    
}
