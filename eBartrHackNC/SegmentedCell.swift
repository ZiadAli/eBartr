//
//  SegmentedCell.swift
//  eBartrHackNC
//
//  Created by Ziad Ali on 10/30/16.
//  Copyright © 2016 ZiadCorp. All rights reserved.
//

import UIKit

class SegmentedCell: UITableViewCell {

    @IBOutlet var cellSegmented: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
