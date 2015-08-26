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
    
    init(collectionView: UICollectionView, parentViewController: UIViewController) {
        self.collectionView = collectionView
        self.parentViewController = parentViewController
        
        super.init()
        var nib = UINib(nibName: "OrganizationCollectionViewCell", bundle: NSBundle.mainBundle())
        self.collectionView!.registerNib(nib, forCellWithReuseIdentifier: "Organization")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        for cell in collectionView.visibleCells() as! [OrganizationCollectionViewCell] {
            cell.organizationProfilePictureImageView.layer.cornerRadius = cell.organizationProfilePictureImageView.bounds.width/2
        }
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
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Organization", forIndexPath: indexPath) as! OrganizationCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.organizationProfilePictureImageView.layer.cornerRadius = cell.organizationProfilePictureImageView.bounds.width/2
        cell.organizationNameLabel.text = "Organization: \(indexPath.row+1)"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        Utilities.presentViewControllerVithStoryboardIdentifier("Organization", parentViewController: parentViewController) {
            (toViewController) -> UIViewController in
            return toViewController
        }
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
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
