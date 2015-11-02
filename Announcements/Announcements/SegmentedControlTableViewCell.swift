//
//  SegmentedControlTableViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 11/1/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class SegmentedControlTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var segments:[String] = [] {
        didSet {
            setupSegments()
        }
    }
    var selectedSegment: Int {
        get {
            return segmentedControl.selectedSegmentIndex
        }
        set {
            segmentedControl.setEnabled(true, forSegmentAtIndex: newValue)
        }
    }
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        segmentedControl.removeAllSegments()
        setupSegments()
    }
    
    func setupSegments() {
        for var i = 0; i < segments.count; ++i {
            let segment = segments[i]
            segmentedControl.insertSegmentWithTitle(segment, atIndex: i, animated: false)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
