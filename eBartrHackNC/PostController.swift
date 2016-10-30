//
//  PostController.swift
//  eBartrHackNC
//
//  Created by Josh Rodriguez and Christian Rust on 10/29/16.
//  Copyright © 2016 ZiadCorp. All rights reserved.
//

import UIKit

class PostController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let postTags = ["Title", "Description", "Type", "Tags", ""]
    
    let postGhost = ["Enter title", "Enter description", "Enter time", "Select tags", ""]
    
    let tags = ["Books", "Cars", "Computers", "Cooking", "Music"]
    
    var picker = UIPickerView()
    var textField = UITextField()
    var titleField = UITextField()
    var descriptionField = UITextField()
    var timeField = UITextField()
    var tagField = UITextField()
    var segmentedField = UISegmentedControl()
    
    override func viewDidLoad() {
        let footerView = UIView(frame: CGRect.zero)
        footerView.alpha = 0
        tableView.tableFooterView = footerView
        let submitButton = UIButton()
        footerView.addSubview(submitButton)
        submitButton.center = footerView.center
        submitButton.titleLabel?.text = "Submit"
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return postTags.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return postTags[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let title = UILabel()
        title.font = UIFont(name: "Helvetica Neue", size: 16)!
        title.textColor = UIColor.gray
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let segmentedCell = tableView.dequeueReusableCell(withIdentifier: "SegmentedCell", for: indexPath) as! SegmentedCell
            segmentedField = segmentedCell.cellSegmented
            return segmentedCell
        }
        
        else if indexPath.section != 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostCell
            if indexPath.section == 0 {titleField = cell.cellTextField}
            else if indexPath.section == 1 {descriptionField = cell.cellTextField}
            else if indexPath.section == 2 {timeField = cell.cellTextField}
            else if indexPath.section == 3 {
                tagField = cell.cellTextField
                cell.cellTextField.inputView = picker
                textField = cell.cellTextField
            }
            cell.cellTextField.placeholder = postGhost[indexPath.section]
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        
        else {
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
            buttonCell.cellButton.addTarget(self, action: #selector(PostController.submitButtonPressed), for: .touchUpInside)
            buttonCell.selectionStyle = UITableViewCellSelectionStyle.none
            return buttonCell
        }
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func submitButtonPressed() {
        let postType = segmentedField.titleForSegment(at: segmentedField.selectedSegmentIndex)
        let post = ["Title":titleField.text!, "Description":descriptionField.text!, "Type":postType!, "Tags":tagField.text!]
        let poster = Poster()
        poster.makePost(post: post)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tags.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = tags[row]
        pickerView.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tags[row]
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let color = (row == pickerView.selectedRow(inComponent: component)) ? UIColor.blue : UIColor.black
        
        return NSAttributedString(string: tags[row], attributes: [NSForegroundColorAttributeName: color])
        
    }
    
    
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


