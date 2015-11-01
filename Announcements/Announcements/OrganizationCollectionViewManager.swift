//
//  OrganizationCollectionViewManager.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/20/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class OrganizationCollectionViewManager: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var parentViewController: UIViewController!
    var refreshDelegate: CollectionViewRefreshDelegate?
    var refreshControl = UIRefreshControl()
    var bottomRefreshControl = UIRefreshControl()
    var startIndex = 0
    var numberOfOrganizations = 10
    var collectionViewTopInset = 8
    var data: [Organization] = []
    var scrollingDelegate: ScrollingDelegate?
    
    
    init(collectionView: UICollectionView, parentViewController: UIViewController, refreshDelegate: CollectionViewRefreshDelegate, shouldRefresh: Bool) {
        self.collectionView = collectionView
        self.parentViewController = parentViewController
        self.refreshDelegate = refreshDelegate
        
        super.init()
        let nib = UINib(nibName: "OrganizationCollectionViewCell", bundle: NSBundle.mainBundle())
        self.collectionView!.registerNib(nib, forCellWithReuseIdentifier: "Organization")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        for cell in collectionView.visibleCells() as! [OrganizationCollectionViewCell] {
            cell.organizationProfilePictureImageView.layer.cornerRadius = cell.organizationProfilePictureImageView.bounds.width/2
        }
        
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: "refreshTop", forControlEvents: UIControlEvents.ValueChanged)
        if shouldRefresh {
            refreshControl.beginRefreshing()
            refreshTop()
        }
        
        collectionView.bottomRefreshControl = bottomRefreshControl
        bottomRefreshControl.addTarget(self, action: "refreshBottom", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refreshTop() {
        startIndex = 0
        refreshControl.beginRefreshing()
        refreshDelegate?.refreshData(refreshControl, collectionView: collectionView)
    }
    
    func refreshBottom() {
        bottomRefreshControl.beginRefreshing()
        startIndex = data.count
        refreshDelegate?.addData(bottomRefreshControl, collectionView: collectionView, startIndex: startIndex, numberOfOrganizations: numberOfOrganizations)
    }
    
    
    func orientationChanged (notification: NSNotification) {
        collectionView.reloadData()
        
        for cell in collectionView!.visibleCells() as! [OrganizationCollectionViewCell] {
            cell.organizationProfilePictureImageView.layer.cornerRadius = cell.organizationProfilePictureImageView.bounds.width/2
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Organization", forIndexPath: indexPath) as! OrganizationCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
//        cell.organizationProfilePictureImageView.layer.cornerRadius = cell.organizationProfilePictureImageView.bounds.width/2
        cell.organization = data[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        Utilities.presentViewControllerVithStoryboardIdentifier("Organization", parentViewController: parentViewController) {
            (toViewController) -> UIViewController in
            let viewController = toViewController as! OrganizationViewController
            viewController.organization = self.data[indexPath.row]
            return viewController
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        let collectionViewCell = cell as! OrganizationCollectionViewCell
//        collectionViewCell.organizationProfilePictureImageView.layer.cornerRadius = collectionViewCell.organizationProfilePictureImageView.bounds.width/2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = self.collectionView.bounds.width
        let numberOfCells = Int(width/148)
        let remainingWidth = Int(width)-(Int(numberOfCells*148)+Int(((numberOfCells+1)*8)))
        let cellWidth: Double = 148 + (Double(remainingWidth)/Double(numberOfCells))
        
        let cellHeight = Double(160/148)*cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(collectionViewTopInset), left: 8, bottom: 8, right: 8)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollingDelegate?.didScroll(scrollView)
    }
}

protocol CollectionViewRefreshDelegate {
    func refreshData(refreshControl: UIRefreshControl, collectionView: UICollectionView)
    func addData(refreshControl: UIRefreshControl, collectionView: UICollectionView, startIndex: Int, numberOfOrganizations: Int)
}
