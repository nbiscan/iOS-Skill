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
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
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
        
        let dim = (navigationController?.navigationBar.frame.size.height)! / 2
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "home"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(homePressed), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: dim, height: dim) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.white
        activityIndicator.backgroundColor = UIColor.black
        activityIndicator.alpha = 0.8
        self.view.addSubview(activityIndicator)

    
    }
    
    func homePressed(){
        self.navigationController?.popToRootViewController(animated: true)
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
