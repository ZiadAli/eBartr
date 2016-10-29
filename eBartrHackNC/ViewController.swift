//
//  ViewController.swift
//  eBartrHackNC
//
//  Created by Ziad Ali on 10/29/16.
//  Copyright © 2016 ZiadCorp. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GeoFire

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    let loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = FIRDatabase.database().reference()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"];
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        loginButton.center = view.center
        let geoFireRef = GeoFire(firebaseRef: ref)
        let location = CLLocation(latitude: 38.8, longitude: 40.1)
        geoFireRef?.setLocation(location, forKey: "Location 1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("Logging in")
        if error != nil {
            print("Error: \(error.localizedDescription)")
            return
        }
        else {
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                else {
                    print("User logged in with Facebook")
                }
            })
        }
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()?.signOut()
        print("User logged out")
    }

}

