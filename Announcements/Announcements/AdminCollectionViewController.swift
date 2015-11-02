//
//  AdminCollectionViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 9/22/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AdminCollectionViewController: UICollectionViewController, CollectionViewRefreshDelegate {

    var orientations:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
    var adminCollectionViewManager: AdminCollectionViewManager!
    var organizations: [Organization] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        adminCollectionViewManager = AdminCollectionViewManager(collectionView: collectionView!, parentViewController: self, refreshDelegate: self, shouldRefresh: false)
        adminCollectionViewManager.data = organizations
        
    }
    
    func refreshData(refreshControl: UIRefreshControl, collectionView: UICollectionView) {
        PFCloud.callFunctionInBackground("getOrganizationsThatUserIsAdminOf", withParameters: nil) {
            (results, error) -> Void in
            if let followers = results as? [Follower] {
                var organizations: [Organization] = []
                for follower in followers {
                    organizations.append(follower.organization)
                }
                self.adminCollectionViewManager.data = organizations
            }
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func addData(refreshControl: UIRefreshControl, collectionView: UICollectionView, startIndex: Int, numberOfOrganizations: Int) {
        PFCloud.callFunctionInBackground("getOrganizationsThatUserIsAdminOf", withParameters: nil) {
            (results, error) -> Void in
            if results != nil {
                let count = (results as! [Organization]).count
                for var i = 0; i < count; ++i {
                    self.adminCollectionViewManager.data.append((results as! [Organization])[i])
                }
            }
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}

class AdminCollectionViewManager : OrganizationCollectionViewManager {
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        Utilities.presentViewControllerVithStoryboardIdentifier("AdminPanel", parentViewController: parentViewController) {
            (toViewController) -> UIViewController in
            let viewController = toViewController as! AdminPanelTableViewController
            viewController.organization = super.data[indexPath.row]
            return viewController
        }
    }
}
