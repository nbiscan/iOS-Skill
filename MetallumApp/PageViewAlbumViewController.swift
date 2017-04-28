//
//  PageViewAlbumViewController.swift
//  MetallumApp
//
//  Created by Five on 28/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class PageViewAlbumViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var views : [UIViewController] = []
    var id : Int64?
    
    convenience init(id : Int64){
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.id = id
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        loadAlbum(id: self.id!)
        self.edgesForExtendedLayout = []
        self.title = "Album info"

        // Do any additional setup after loading the view.
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if (viewController is AlbumViewController){
            self.title = "Album info"
            return views[1]
        } else if (viewController is SongsTableViewController){
            self.title = "Songs"
            return views[2]
        } 
        self.title = "Personnel"
        return views[0]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (viewController is SongsTableViewController){
            self.title = "Songs"
            return views[0]
        } else if (viewController is ArtistsViewController){
            self.title = "Personnel"
            return views[1]
        }
        self.title = "Album info"
        return views[2]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return views.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
        
    
    
}
