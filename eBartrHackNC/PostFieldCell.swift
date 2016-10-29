//
//  PostFieldCell.swift
//  eBartrHackNC
//
//  Created by Josh Rodriguez on 10/29/16.
//  Copyright © 2016 ZiadCorp. All rights reserved.
//

import UIKit

class PostFieldCell: UITableViewCell {
    
    @IBOutlet weak var cellTextField: UITextField!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
