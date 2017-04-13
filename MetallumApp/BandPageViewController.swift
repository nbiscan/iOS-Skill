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

        self.dataSource = self
        self.edgesForExtendedLayout = []
        
        loadBand(id: id!)
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (viewController is BandViewController){
            return views[1]
        } else if (viewController is BioViewController){
            return views[2]
        } else if (viewController is ArtistsViewController){
            return views[3]
        }
        return views[0]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (viewController is BioViewController){
            return views[0]
        } else if (viewController is ArtistsViewController){
            return views[1]
        } else if ( viewController is AlbumsViewController){
            return views[2]
        }
        return views[3]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return views.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}
