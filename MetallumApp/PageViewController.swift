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
        
        self.edgesForExtendedLayout = []
        
        views.append(FavouriteBandViewController(dataStore : dataStore!, band : band!))
        views.append(BandBioViewController(dataStore : dataStore!, band : band!))
        views.append(BandArtistsViewController(band : band!))
        views.append(BandAlbumsViewController(band : band!))
        
        self.setViewControllers([views[0]], direction: .forward, animated: true, completion: nil)
        
        let dim = (navigationController?.navigationBar.frame.size.height)! / 2
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "home"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(homePressed), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: dim, height: dim) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    func homePressed(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        if (viewController is FavouriteBandViewController){
            if let _ = band?.bio{
                return views[1]
            }
            return views[2]
        } else if (viewController is BandBioViewController){
            return views[2]
        } else if (viewController is BandArtistsViewController) {
            return views[3]
        } else {
            return views[0]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if (viewController is FavouriteBandViewController){
            return views[3]
        } else if (viewController is BandBioViewController){
            return views[0]
        } else if (viewController is BandArtistsViewController) {
            if let _ = band?.bio{
                return views[1]
            }
            return views[0]
        } else {
            return views[2]
        }
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        if let _ = band?.bio{
            return views.count
        }
        return views.count - 1
    }
    
}
