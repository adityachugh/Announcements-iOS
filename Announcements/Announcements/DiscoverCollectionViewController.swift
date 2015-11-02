//
//  DiscoverCollectionViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/18/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class DiscoverCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CollectionViewRefreshDelegate {
    
    var orientations:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
    var organizationCollectionViewManager: OrganizationCollectionViewManager!
    var followingOrganizations: [Organization] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        organizationCollectionViewManager = OrganizationCollectionViewManager(collectionView: collectionView!, parentViewController: self, refreshDelegate: self, shouldRefresh: true)
    }
    
    func refreshData(refreshControl: UIRefreshControl, collectionView: UICollectionView) {
        let parameters: Dictionary = ["startIndex": 0, "numberOfOrganizations": 10, "userObjectId": PFUser.currentUser()!.objectId!]  as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getOrganizationsForDiscoverTabInRange", withParameters: parameters) {
            (results, error) -> Void in
            if let organizations = results as? [Organization] {
                self.organizationCollectionViewManager.data = organizations
            }
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func addData(refreshControl: UIRefreshControl, collectionView: UICollectionView, startIndex: Int, numberOfOrganizations: Int) {
        let parameters: Dictionary = ["startIndex": startIndex, "numberOfOrganizations": numberOfOrganizations, "userObjectId": PFUser.currentUser()!.objectId!]  as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getOrganizationsForDiscoverTabInRange", withParameters: parameters) {
            (results, error) -> Void in
            if results != nil {
                for result in results as! [Organization] {
                    self.organizationCollectionViewManager.data.append(result)
                }
            }
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}