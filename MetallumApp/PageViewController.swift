//
//  PageViewController.swift
//  MetallumApp
//
//  Created by Five on 11/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var dataStore : DataStore?
    var band : Band?
    
    var views : [UIViewController] = []
    
    convenience init(dataStore : DataStore, band : Band){
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.dataStore = dataStore
        self.band = band
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
//        self.automaticallyAdjustsScrollViewInsets = false
//        self.definesPresentationContext = true
        self.navigationController?.navigationBar.isTranslucent = false
        // self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        views.append(FavouriteBandViewController(dataStore : dataStore!, band : band!))
        views.append(BandBioViewController(dataStore : dataStore!, band : band!))
        
//        views[0].modalPresentationStyle = .currentContext
//        views[1].modalPresentationStyle = .currentContext
        
        self.setViewControllers([views[0]], direction: .forward, animated: true, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if (viewController is FavouriteBandViewController){
            return views[1]
        } else {
            return views[0]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (viewController is FavouriteBandViewController){
            return views[1]
        } else {
            return views[0]
        }
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return views.count
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
