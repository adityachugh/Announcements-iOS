//
//  StatusIndicator.swift
//  infor[me]
//
//  Created by Aditya Chugh on 10/17/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class StatusIndicator: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let trueImage = UIImage(named: "checkmark_filled")
    let falseImage = UIImage(named: "delete_sign_filled")
    
    var status = Status.None {
        didSet {
            switch status {
            case .None:
                statusImageView.hidden = true
                activityIndicator.hidden = true
                activityIndicator.stopAnimating()
            case .True:
                statusImageView.hidden = false
                activityIndicator.hidden = true
                statusImageView.image = trueImage
                activityIndicator.stopAnimating()
            case .False:
                statusImageView.hidden = false
                activityIndicator.hidden = true
                statusImageView.image = falseImage
                activityIndicator.stopAnimating()
            case .Loading:
                statusImageView.hidden = true
                activityIndicator.hidden = false
                activityIndicator.startAnimating()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("StatusIndicator", owner: self, options: nil)
        self.addSubview(view)
        status = .None
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("StatusIndicator", owner: self, options: nil)
        self.bounds = self.view.bounds
        self.addSubview(view)
        status = .None
    }
    
    override func prepareForInterfaceBuilder() {
        if #available(iOS 8.0, *) {
            super.prepareForInterfaceBuilder()
        } else {
            // Fallback on earlier versions
        }
    }
    
    enum Status {
        case None
        case True
        case Loading
        case False
    }
}
