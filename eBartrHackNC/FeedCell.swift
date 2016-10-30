//
//  FeedCell.swift
//  eBartrHackNC
//
//  Created by Ziad Ali on 10/29/16.
//  Copyright © 2016 ZiadCorp. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    
    @IBOutlet var postType: UILabel!
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var postDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func testPost(_ sender: AnyObject) {
        let poster = Poster()
        var post = [String:String]()
        print("Testing post")
        if let user = FIRAuth.auth()?.currentUser?.uid {
            post = ["Title":"Wassup Everybody", "Description":"I'm Dr. Nick", "User":user, "Type":"Request"]
        }
        else {
            post = ["Title":"Wassup Everybody", "Description":"I'm Dr. Nick", "User":"nil", "Type":"Owner"]
        }
        poster.makePost(currentLocation: currentLocation, post: post)
    }
}
