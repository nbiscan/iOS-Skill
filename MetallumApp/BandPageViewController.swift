//
//  BandPageViewController.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class BandPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var views : [UIViewController] = []
    var band : BandStructure = BandStructure()
    var id : Int64?
    
    convenience init(id : Int64){
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.id = id
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Band info"
        
        self.dataSource = self
        self.edgesForExtendedLayout = []
        
        loadBand(id: id!)
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (viewController is BandViewController){
            self.title = "Band info"
            return views[1]
        } else if (viewController is BioViewController){
            self.title = "Biography"
            return views[2]
        } else if (viewController is ArtistsViewController){
            self.title = "Artists"
            return views[3]
        }
        self.title = "Albums"
        return views[0]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (viewController is BioViewController){
            self.title = "Biography"
            return views[0]
        } else if (viewController is ArtistsViewController){
            self.title = "Artists"
            return views[1]
        } else if ( viewController is AlbumsViewController){
            self.title = "Albums"
            return views[2]
        }
        self.title = "Band info"
        return views[3]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return views.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}
