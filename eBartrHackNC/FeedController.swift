//
//  FeedController.swift
//  eBartrHackNC
//
//  Created by Ziad Ali on 10/29/16.
//  Copyright © 2016 ZiadCorp. All rights reserved.
//

import UIKit
import Firebase
import GeoFire

class FeedController: UITableViewController, CLLocationManagerDelegate {

    var posts = [[String:String]]()
    let locationManagerApp = CLLocationManager()
    var appLocation = CLLocationCoordinate2D()
    var initializedLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        initializeLocationServices()
        self.refreshControl?.addTarget(self, action: #selector(FeedController.refresh), for: .valueChanged)
        var post = [String:String]()
        post["Title"] = "Testing"
        post["Description"] = "123"
        post["Type"] = "Request"
        posts.append(post)
        tableView.refreshControl?.beginRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    func initializeLocationServices() {
        locationManagerApp.requestAlwaysAuthorization()
        locationManagerApp.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManagerApp.delegate = self
            locationManagerApp.desiredAccuracy = kCLLocationAccuracyBest
            locationManagerApp.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        appLocation = manager.location!.coordinate
        if !initializedLocation {
            initializeReloaded()
            initializedLocation = true
        }
    }
    
    func initializeReloaded() {
        var ref = FIRDatabase.database().reference()
        let geoFireRef = GeoFire(firebaseRef: ref.child("Locations"))
        ref = ref.child("Posts")
        let location = CLLocation(latitude: appLocation.latitude, longitude: appLocation.longitude)
        print("Current Latitude: \(location.coordinate.latitude) Current Longitude: \(location.coordinate.longitude)")
        let query = geoFireRef?.query(at: CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), withRadius: 5000.0)
        query?.observe(GFEventType.keyEntered, with: { (key, location) in
            guard let key = key else {return}
            guard let location = location else {return}
            ref.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                var post = [String:String]()
                post["Title"] = value?["Title"] as? String
                post["Description"] = value?["Description"] as? String
                post["Type"] = value?["Type"] as? String
                self.posts.append(post)
            })
            print("Key: \(key) Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
        })
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        for post in posts {
            print("Post: \(post["Title"])")
        }
        print("Activated Refresh")
        print("Count: \(posts.count)")
        if (self.refreshControl?.isRefreshing)! {
            self.refreshControl?.endRefreshing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        let post = posts[indexPath.row]
        cell.postTitle.text = post["Title"]
        cell.postDescription.text = post["Description"]
        cell.postType.text = post["Type"]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
