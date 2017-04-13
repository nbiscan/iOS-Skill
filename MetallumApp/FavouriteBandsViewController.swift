//
//  FavouriteBandsViewController.swift
//  MetallumApp
//
//  Created by Five on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit
import CoreData

let cellIndentifier = "cell"

class FavouriteBandsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>!
    
    var dataStore : DataStore = (UIApplication.shared.delegate as! AppDelegate).dataStore
    
    convenience init(dataStore: DataStore){
        self.init()
        self.dataStore = dataStore
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Favourite Bands"
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIndentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        initializeFetchResultsContoller()
        
    }
    
    func initializeFetchResultsContoller(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Band")
        let bandIdSort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [bandIdSort]
        
        fetchedResultsController =  NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataStore.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print((fetchedResultsController.sections?[section].numberOfObjects)!)
        return (fetchedResultsController.sections?[section].numberOfObjects)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as! TableViewCell
        
        let band = self.fetchedResultsController?.object(at: indexPath) as! Band
        cell.setup(with: indexPath.row, band: band)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let band = self.fetchedResultsController?.object(at: indexPath) as! Band
        let bandPageViewController = PageViewController(dataStore : dataStore, band : band)
        navigationController?.pushViewController(bandPageViewController, animated: true)
    }
    
    
    
    
}
