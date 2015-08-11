//
//  PostTableViewCell.swift
//  Announcements
//
//  Created by Aditya Chugh on 8/7/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.autoresizesSubviews = true
        
//        self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.frame.width, height: self.view.frame.height)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("PostTableViewCell", owner: self, options: nil)
        self.addSubview(view)
        setup()
    }
    
    func setup() {
    }
}