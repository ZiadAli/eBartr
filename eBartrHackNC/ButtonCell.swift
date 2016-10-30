//
//  ButtonCell.swift
//  eBartrHackNC
//
//  Created by Christian Rust on 10/29/16.
//  Copyright © 2016 ZiadCorp. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    

    @IBOutlet weak var cellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
