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
import CoreLocation

var currentLocation = CLLocationCoordinate2D()

class LoginController: UIViewController, CLLocationManagerDelegate, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var buttonView: FBSDKLoginButton!
    let loginButton = FBSDKLoginButton()
    let appLocationManager = CLLocationManager()
    //var geoFireRef = GeoFire()
    // testing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFacebook()
        initializeLocationServices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makePost(_ sender: AnyObject) {
        let poster = Poster()
        var post = [String:String]()
        if let user = FIRAuth.auth()?.currentUser?.uid {
            post = ["Title":"Wassup Everybody", "Description":"I'm Dr. Nick", "User":user]
        }
        else {
            post = ["Title":"Wassup Everybody", "Description":"I'm Dr. Nick", "User":"nil"]
        }
        poster.makePost(post: post)
    }
    
    func initializeFacebook() {
        buttonView.readPermissions = ["public_profile", "email", "user_friends"]
        buttonView.delegate = self
    }
    
    func initializeLocationServices() {
        appLocationManager.requestAlwaysAuthorization()
        appLocationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            appLocationManager.delegate = self
            appLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            appLocationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location!.coordinate
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
                    self.performSegue(withIdentifier: "showNavigation", sender: loginButton)
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

