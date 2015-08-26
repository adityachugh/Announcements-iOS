//
//  DiscoverCollectionViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/18/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class DiscoverCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var orientations:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
    var organizationCollectionViewManager: OrganizationCollectionViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        organizationCollectionViewManager = OrganizationCollectionViewManager(collectionView: collectionView!, parentViewController: self)
        
    }
    
    

    
    
}
