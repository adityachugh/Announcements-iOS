//
//  CommentButton.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/11/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class CommentButton: UIView {

    @IBOutlet weak var view: UIView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var commentCountLabel: UILabel!
    var commentCount: Int? {
        get {
            return commentCountLabel.text?.toInt()
        }
        set {
            commentCountLabel.text = "\(newValue!)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("CommentButton", owner: self, options: nil)
        self.bounds = self.view.bounds
        self.addSubview(view)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("CommentButton", owner: self, options: nil)
        self.addSubview(view)
        setup()
    }
    
    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        println("Hello!")
    }
    
    func setup() {
        commentCount = 12
    }
}
