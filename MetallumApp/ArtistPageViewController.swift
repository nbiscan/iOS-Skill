//
//  ArtistPageViewController.swift
//  MetallumApp
//
//  Created by Five on 02/05/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class ArtistPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var views : [UIViewController] = []
    var id : Int64?
    
    convenience init(id : Int64){
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.id = id
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadArtist(id: id!)
        self.edgesForExtendedLayout = []
        self.dataSource = self
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (viewController is ArtistViewController){
            self.title = "Artist info"
            return views[1]
        } else if (viewController is ArtistBiographyViewController){
            self.title = "Biography"
            return views[2]
        } else if (viewController is ActiveBandsTableViewController){
            self.title = "Active bands"
            return views[3]
        } else {
            self.title = "Past bands"
            return views[0]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (viewController is ArtistViewController){
            self.title = "Artist info"
            return views[3]
        } else if (viewController is ArtistBiographyViewController){
            self.title = "Biography"
            return views[0]
        } else if (viewController is ActiveBandsTableViewController){
            self.title = "Active bands"
            return views[1]
        } else {
            self.title = "Past bands"
            return views[2]
        }
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return views.count
    }

    

}
