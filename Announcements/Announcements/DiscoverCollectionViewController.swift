//
//  DiscoverCollectionViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/18/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class DiscoverCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        var nib = UINib(nibName: "OrganizationCollectionViewCell", bundle: NSBundle.mainBundle())
        self.collectionView!.registerNib(nib, forCellWithReuseIdentifier: "Organization")
        
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Organization", forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        Utilities.presentViewControllerVithStoryboardIdentifier("Organization", parentViewController: self) {
            (toViewController) -> UIViewController in
            return toViewController
        }
    }
    
}
