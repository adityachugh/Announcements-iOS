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
    var isFollowing = false
    
    override func awakeFromNib() {
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.backgroundColor = UIColor.clearColor()
        hideActivityIndicator()
        setFollow()
    }
    @IBAction func followButtonPressed(sender: AnyObject) {
        isFollowing = !isFollowing
        if !isFollowing {
            setFollow()
        } else {
            showActivityIndicator()
            Utilities.delayTime(1, closure: {
                () -> () in
                self.setUnfollow()
                self.hideActivityIndicator()
            })
        }
    }
    
    private func setFollow() {
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
    
    private func setUnfollow() {
        Utilities.animate {
            () -> () in
            self.button.setTitle("Unfollow", forState: UIControlState.Normal)
            self.button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.button.backgroundColor = UIColor.AccentColor()
            self.button.layer.cornerRadius = self.button.frame.size.height/2
            self.button.layer.borderWidth = 0
            self.button.layer.borderColor = UIColor.AccentColor().CGColor
        }
    }
    
    private func showActivityIndicator() {
        Utilities.animate {
            () -> () in
            self.button.alpha = 0
            self.button.layer.borderColor = UIColor.clearColor().CGColor
            self.button.layer.borderWidth = 0
            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    private func hideActivityIndicator() {
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
