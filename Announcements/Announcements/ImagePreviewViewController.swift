//
//  ImagePreviewViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 12/24/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {

    @IBOutlet weak var imageView: PFImageView!
    @IBOutlet weak var noImageLabel: UILabel!
    
    var image: PFFile? {
        didSet {
            if imageView != nil {
                imageView.file = image
                if let _ = image {
                    noImageLabel.hidden = true
                } else {
                    noImageLabel.hidden = false
                }

            }
        }
    }
    var actionButtonTitle: String? {
        didSet {
            if let actionButtonTitle = actionButtonTitle {
                navigationItem.rightBarButtonItem?.title = actionButtonTitle
            }
            else {
                navigationItem.rightBarButtonItem?.title = ""
            }
        }
    }
    var action: (rootViewController:UIViewController)->()?
    
    required init(coder aDecoder: NSCoder) {
        action = {_ in 
            return nil
        }
        super.init(coder: aDecoder)!

    }
    
    override func viewWillAppear(animated: Bool) {
        imageView.loadInBackground()
    }
    
    override func viewDidLoad() {
        imageView.file = image
        noImageLabel.textColor = UIColor.grayColor()
        noImageLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        if let _ = image {
            noImageLabel.hidden = true
        } else {
            noImageLabel.hidden = false
        }
        var title = ""
        if let actionButtonTitle = actionButtonTitle {
            title = actionButtonTitle
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: "actionButtonTapped")
    }
    
    func actionButtonTapped() {
        action(rootViewController: self)
    }
}