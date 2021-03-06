//
//  TableViewController.swift
//  RandomUser
//
//  Created by Chris Harding on 3/5/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var users = [Users]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem?.isEnabled = false
        users = Users.loadFromFile()
        print(users)
        if users.isEmpty {
            loadExampleUsers()
            Users.savetoFile(users: users)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func loadExampleUsers() {
        let newUser1 = Users(name: "Sally", age: 21)
        let newUser2 = Users(name: "John", age: 21)
        let newUser3 = Users(name: "Sam", age: 31)
        let newUser4 = Users(name: "Amanda", age: 34)
        users += [newUser1,newUser2,newUser3,newUser4]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = String(user.age)
        

        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Users.savetoFile(users: users)
        } else if editingStyle == .insert {
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RandomUser" {
            let user = users.shuffled()
            let navController = segue.destination as! UINavigationController
            let detailTableViewController = navController.topViewController as! DetailTableViewController
            
            detailTableViewController.user = user[0]
            detailTableViewController.editMode = false
            detailTableViewController.self.title = "Random User"
            detailTableViewController.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        if segue.identifier == "EditUser" {
            if let indexPath = tableView.indexPathForSelectedRow {
            let user = users[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let detailTableViewController = navController.topViewController as! DetailTableViewController
            
            detailTableViewController.user = user
            detailTableViewController.self.title = "\(user.name), \(user.age)"
            detailTableViewController.addMode = false
            }
        }
        if segue.identifier == "addUser" {
            if let selectedRow = tableView.indexPathsForSelectedRows {
                tableView.deselectRow(at: selectedRow[0], animated: false)
                navigationItem.leftBarButtonItem?.isEnabled = false
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.leftBarButtonItem?.isEnabled = true
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind",
        let sourceViewController = segue.source as?
        DetailTableViewController,
            let user = sourceViewController.user else {return}
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow
        {
            users[selectedIndexPath.row] = user
            tableView.reloadRows(at: [selectedIndexPath]
                                 , with: .none)
        } else {
            let newIndexPath = IndexPath(row: users.count, section: 0)
            users.append(user)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
        Users.savetoFile(users: users)
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
