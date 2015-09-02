//
//  UserViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/20/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, CollectionViewRefreshDelegate {
    
    
    @IBOutlet weak var userProfilePictureImageView: PFImageView!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var organizationsCountLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var organizationCollectionViewManager: OrganizationCollectionViewManager!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        organizationCollectionViewManager = OrganizationCollectionViewManager(collectionView: collectionView, parentViewController: self, refreshDelegate: self)
        
        if let profilePhotoFile = user.profilePhoto {
            userProfilePictureImageView.file = profilePhotoFile
            userProfilePictureImageView.loadInBackground({ (image, error) -> Void in })
        }
        
        title = "\(user.firstName) \(user.lastName)"
        userProfilePictureImageView.layer.cornerRadius = userProfilePictureImageView.frame.size.height / 2
        userProfilePictureImageView.layer.masksToBounds = true
        userHandleLabel.text = "@\(user.username!)"
        organizationsCountLabel.text = "\(user.organizationsFollowedCount) Organizations"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshData(refreshControl: UIRefreshControl, collectionView: UICollectionView) {
        var parameters: Dictionary = ["startIndex": 0, "numberOfOrganizations": 10, "userObjectId": user.objectId!]  as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getOrganizationsFollowedByUserInRange", withParameters: parameters) {
            (results, error) -> Void in
            if let organizations = results as? [Follower] {
                self.organizationCollectionViewManager.data = []
                for result in results as! [Follower] {
                    self.organizationCollectionViewManager.data.append(result.organization)
                }
            }
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func addData(refreshControl: UIRefreshControl, collectionView: UICollectionView, startIndex: Int, numberOfOrganizations: Int) {
        var parameters: Dictionary = ["startIndex": startIndex, "numberOfOrganizations": numberOfOrganizations, "userObjectId": user.objectId!]  as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getOrganizationsFollowedByUserInRange", withParameters: parameters) {
            (results, error) -> Void in
            if results != nil {
                for result in results as! [Follower] {
                    self.organizationCollectionViewManager.data.append(result.organization)
                }
            }
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
