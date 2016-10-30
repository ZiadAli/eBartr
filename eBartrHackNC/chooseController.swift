//
//  ChooseController.swift
//  eBartrHackNC
//
//  Created by Christian Rust on 10/29/16.
//  Copyright © 2016 ZiadCorp. All rights reserved.
//

import UIKit


class ChooseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        newRequestButton.layer.cornerRadius = 5;
        newRequestButton.layer.borderWidth = 1;
        
        newOfferButton.layer.cornerRadius = 5;
        newOfferButton.layer.borderWidth = 1;
        
        
        //view.layer.masksToBounds = YES;
        //let customDarkOrange = UIColor(red: 255/255.0, green: 160/255.0, blue: 0/255.0, alpha: 1.0)

        //newRequestButton.backgroundColor = customDarkOrange
            
        //newOfferButton.backgroundColor = customDarkOrange
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var newRequestButton: UIButton!

    @IBOutlet weak var newOfferButton: UIButton!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
