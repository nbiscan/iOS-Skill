//
//  BandPageViewController.swift
//  MetallumApp
//
//  Created by Five on 13/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

class RandomBandPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var views : [UIViewController] = []
    var band : BandStructure = BandStructure()
    var id : Int64?
    var random : Bool?
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    convenience init(){
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Random band"

        self.dataSource = self
        self.edgesForExtendedLayout = []
        
        loadBand()
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.white
        activityIndicator.backgroundColor = UIColor.black
        activityIndicator.alpha = 0.8
        self.view.addSubview(activityIndicator)
        
//        activityIndicator.startAnimating()
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (viewController is RandomBandViewController){
            return views[1]
        } else if (viewController is ArtistsViewController){
            return views[2]
        }
        return views[0]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (viewController is ArtistsViewController){
            return views[0]
        } else if ( viewController is AlbumsViewController){
            return views[1]
        }
        return views[2]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return views.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}
