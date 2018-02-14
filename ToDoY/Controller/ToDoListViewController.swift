//
//  ViewController.swift
//  ToDoY
//
//  Created by Ishay on 2/11/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray : [Item] = [Item]()
    
    // setting the reference to UserDefaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem : Item = Item()
        newItem.title = "L"
        itemArray.append(newItem)
        
        let newItem2 : Item = Item()
        newItem.title = "Lir"
        itemArray.append(newItem2)
        
        let newItem3 : Item = Item()
        newItem.title = "Liraz"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToSoListArray") as? [Item] {
            itemArray = items
        }
    }

    //MARK: Table Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let item : Item = itemArray[indexPath.row]
        
        // because the itemArray is now an Item and not a String
        cell.textLabel?.text = item.title
        
        // Ternary Operator
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // short way
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // long way
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
    
    // change appearance of selected row
    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add new items
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // add text field to popup alert
        let alert = UIAlertController(title: "Add New ToDoY Item", message: "", preferredStyle: .alert)
        
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        //create actionto alert
        let action = UIAlertAction(title: "Add Item", style: .default)
            { (action) in
                // what will happen when the user clicks add
                let newItem : Item = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                
                // saving to UserDefaults
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                
                // reload 
                self.tableView.reloadData()
        }
        
        
        alert.addAction(action)
        
        // show popup
        present(alert, animated: true, completion: nil)
        //present(alert, animated: true, completion: nil)
    }
    
}

