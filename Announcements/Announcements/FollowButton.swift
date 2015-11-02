//
//  FollowButton.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/19/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class FollowButton: UIView {
    
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    var followStatus: String = "NFO" {
        didSet {
            switch followStatus {
            case "NFO":
                setNotFollower()
            case "FOL", "ADM":
                setFollower()
            case "PEN":
                setPending()
            case "REJ":
                setRejected()
            default:
                setNotFollower()
            }
        }
    }
    var delegate: FollowButtonDelegate?
    override func awakeFromNib() {
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.backgroundColor = UIColor.clearColor()
        hideActivityIndicator()
        setNotFollower()
    }
    @IBAction func followButtonPressed(sender: AnyObject) {
       delegate?.followButtonTapped(followStatus)
    }
    
    func setNotFollower() {
        Utilities.animate {
            () -> () in
            self.button.setTitle("Follow", forState: UIControlState.Normal)
            self.button.setTitleColor(UIColor.AccentColor(), forState: UIControlState.Normal)
            self.button.backgroundColor = UIColor.clearColor()
            self.button.layer.cornerRadius = self.button.frame.size.height/2
            self.button.layer.borderWidth = 2
            self.button.layer.borderColor = UIColor.AccentColor().CGColor
        }
        
    }
    
    func setFollower() {
        Utilities.animate {
            () -> () in
            self.button.setTitle("Following", forState: UIControlState.Normal)
            self.button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.button.backgroundColor = UIColor.AccentColor()
            self.button.layer.cornerRadius = self.button.frame.size.height/2
            self.button.layer.borderWidth = 0
            self.button.layer.borderColor = UIColor.AccentColor().CGColor
        }
    }
    
    func setRejected() {
        Utilities.animate {
            () -> () in
            self.button.setTitle("Rejected", forState: UIControlState.Normal)
            self.button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.button.backgroundColor = UIColor.redColor()
            self.button.layer.cornerRadius = self.button.frame.size.height/2
            self.button.layer.borderWidth = 0
            self.button.layer.borderColor = UIColor.AccentColor().CGColor
        }
    }
    
    func setPending() {
        Utilities.animate {
            () -> () in
            self.button.setTitle("Pending", forState: UIControlState.Normal)
            self.button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.button.backgroundColor = UIColor.orangeColor()
            self.button.layer.cornerRadius = self.button.frame.size.height/2
            self.button.layer.borderWidth = 0
            self.button.layer.borderColor = UIColor.AccentColor().CGColor
        }
    }
    
    func showActivityIndicator() {
        Utilities.animate {
            () -> () in
            self.button.alpha = 0
            self.button.layer.borderColor = UIColor.clearColor().CGColor
            self.button.layer.borderWidth = 0
            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        Utilities.animate {
            () -> () in
            self.button.alpha = 1
            self.activityIndicator.hidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("FollowButton", owner: self, options: nil)
        self.addSubview(view)
        self.hideActivityIndicator()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("FollowButton", owner: self, options: nil)
        self.bounds = self.view.bounds
        self.addSubview(view)
        self.hideActivityIndicator()
    }
    
//    func loadViewFromNib() -> UIView {
//        let bundle = NSBundle(forClass: self.dynamicType)
//        UINib(nibName: "FollowButton", bundle: bundle)
//    }
    
}

protocol FollowButtonDelegate {
    func followButtonTapped(followStatus: String)
}