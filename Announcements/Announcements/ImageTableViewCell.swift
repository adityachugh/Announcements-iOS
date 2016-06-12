//
//  ImageTableViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 11/1/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var parentViewController: UIViewController?
    var currentImage: PFFile?
    var action: (parentViewController:UIViewController)->()?
    var previewViewController: ImagePreviewViewController!
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        action = { _ in return nil}
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            previewViewController = Utilities.getViewControllerWithStoryboardIdentifier("ImagePreview", parentViewController: parentViewController!) as! ImagePreviewViewController
            previewViewController.action = self.action
            previewViewController.image = currentImage
            previewViewController.title = title
            previewViewController.actionButtonTitle = "Change"
            parentViewController?.navigationController?.pushViewController(previewViewController, animated: true)
        }
    }
    
}
