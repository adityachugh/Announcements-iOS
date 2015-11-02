//
//  SwitchTableViewCell.swift
//  
//
//  Created by Aditya Chugh on 11/1/15.
//
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateSwitch: UISwitch!
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    var isOn: Bool! {
        get {
            return stateSwitch.on
        }
        set {
            stateSwitch.setOn(newValue, animated: true)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stateSwitch.onTintColor = UIColor.AccentColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
