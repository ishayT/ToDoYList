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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Shoshana.plist")
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
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
        
        saveItems()
        
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
                
                // caling the saveItems method
                self.saveItems()
                
                // reload 
                self.tableView.reloadData()
        }
        
        
        alert.addAction(action)
        
        // show popup
        present(alert, animated: true, completion: nil)
        //present(alert, animated: true, completion: nil)
    }
    
    // Mark: - Model manipulaton Methods
    
    func saveItems() {
        // create an encoder
        let encoder : PropertyListEncoder = PropertyListEncoder()
        
        do {
            // encoding the
            let data = try encoder.encode(itemArray)
            // writing our data custom file
            try data.write(to: dataFilePath!)
        } catch {
            print("Error saving item array: \(error)")
        }
    }
    
    func loadItems() {
        
        do {
            let data = try Data(contentsOf: dataFilePath!)
            let decodar : PropertyListDecoder = PropertyListDecoder()
            
            // this is the method that decodes our data. we have to specify what is the data type of the decoded value.
            // our data is array of item - [Item]. we have to add the .self so it will know that we are referring to our Item type and not an Object.
            itemArray = try decodar.decode([Item].self, from: data)
        } catch {
            print("Error decoding item array: \(error)")
        }
        
//        if let dataTwo = try? Data(contentsOf: dataFilePath!) {
//            let decoderTwo : PropertyListDecoder = PropertyListDecoder()
//            do {
//                itemArray = try decoderTwo.decode([Item].self, from: dataTwo)
//            } catch {
//                print("Error decoding item array: \(error)")
//            }
//        }
    }
}

