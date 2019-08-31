//
//  ViewController.swift
//  coreDataToDo
//
//  Created by Amith Kumar Narayan on 17/08/2019.
//  Copyright © 2019 Amith. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {

    var itemArray = ["Amith", "Ranjan", "Mark", "Tony"]
    
    //cretating a User default for storing key value pares.
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //loding data using user defaults
        if let items = defaults.array(forKey: "TodoListKey") as? [String] {
            itemArray = items
        }

    }

    //MARK - TableView Datasourse methods
    //Returns the number of rows need to be created in the list.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //This method is called on the creation of the list.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //gets the reference of the cell using an identifier and adds the list to the cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate methods
    //This method is called when the user taps on the item of the list.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if it has a checkmark it unchecks and if it dosn't it adds a checkmark.
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new item
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) {
            (action) in
            //perform actions once the add button is pressed.
            
            //checks the textfield if it's empty.
            if textField.text!.isEmpty != true {
                
                //appends the list and displays it.
                self.itemArray.append(textField.text!)
                
                //storing the array using key-value by defaults.
                self.defaults.set(self.itemArray, forKey: "TodoListKey")
                
                self.tableView.reloadData()
            }
        }
        
        //This is the alert text field which is added to the alert.
        alert.addTextField { (alertText) in
            alertText.placeholder = "Please type your todo!"
            textField = alertText
        }
        alert.addAction(action)
        
        //this presents the allert.
        present(alert, animated: true, completion: nil)
    }

}

