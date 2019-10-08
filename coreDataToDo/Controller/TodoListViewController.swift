//
//  ViewController.swift
//  coreDataToDo
//
//  Created by Amith Kumar Narayan on 17/08/2019.
//  Copyright © 2019 Amith. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController : UITableViewController {

    var itemArray = [ItemsEntity]()
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    //trying to get viewContext of persistentContainer from AppDelegate file and we are creating an object of live application and down-casting it to AppDelegate.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //this lodes all the items from the plist.
//        lodeItems()
    }

    //MARK: - TableView Datasourse methods
    //Returns the number of rows need to be created in the list.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //This method is called on the creation of the list and reuse the same cell when scrolled.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //gets the reference of the cell using an identifier and adds the list to the cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.check ? .checkmark : .none
//        if item.check == true {
//            cell.accessoryType = .checkmark
//        } else if item.check == false {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK: - TableView Delegate methods
    //This method is called when the user taps on the item of the list.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].check = !(itemArray[indexPath.row].check)
        
        self.saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add new item
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) {
            (action) in
            //perform actions once the add button is pressed.
            
            let newItem = ItemsEntity(context: self.context)
            
            
            //checks the textfield if it's empty.
            if textField.text!.isEmpty != true {
                
                //adding alertText to tile of the obj.
                newItem.title = textField.text!
                newItem.check = false
                //appends the list and displays it.
                self.itemArray.append(newItem)
                
                self.saveData()
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

    func saveData() {
        do {
            try context.save()
        } catch {
            print("-----> error saving context , \(error)")
        }
        
        self.tableView.reloadData()
    }
    
//    func lodeItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Items].self, from: data)
//            } catch {
//                print("-----> error Decoding or writing, \(error)")
//            }
//        }
//    }
}

//this is a testion commit!

