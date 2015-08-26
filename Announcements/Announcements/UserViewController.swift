//
//  UserViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/20/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var organizationCollectionViewManager: OrganizationCollectionViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        organizationCollectionViewManager = OrganizationCollectionViewManager(collectionView: collectionView, parentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
