//
//  DetailTableViewController.swift
//  RandomUser
//
//  Created by Chris Harding on 3/5/21.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var user: Users?
    var editMode: Bool = true
    var addMode: Bool = true
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var ageTextField: UILabel!
    
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var ageTextInput: UITextField!
    
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var ageCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        
        if let user = user {
            nameTextField.text = user.name
            ageTextField.text = String(user.age)
            print("userfound")
            if addMode == false {
                
                self.title = "\(user.name), \(user.age)"
                nameTextField.text = "Enter new name"
                ageTextField.text = "Enter new age"
            }
        }
        if editMode == false {
            nameTextInput.isHidden = true
            ageTextInput.isHidden = true
        } else {
            nameTextInput.isHidden = false
            ageTextInput.isHidden = false
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let name = nameTextInput.text ?? ""
        let age = ageTextInput.text ?? ""
        user = Users(name: name, age: Int(age) ?? 0)
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
