//
//  TextViewTableViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 11/1/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var title: String? {
        get {
            return titleLabel.text
        } set {
            titleLabel.text = newValue
        }
    }
    var body: String! {
        get {
            return bodyTextView.text
        } set {
            bodyTextView.text = newValue
        }
    }
//    var placeholder: String? {
//        get {
//            return bodyTextView.placeholder
//        } set {
//            bodyTextView.placeholder = newValue
//        }
//    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            bodyTextView.becomeFirstResponder()
        }
    }
}
