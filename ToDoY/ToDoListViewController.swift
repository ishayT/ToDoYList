//
//  ViewController.swift
//  ToDoY
//
//  Created by Ishay on 2/11/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray : [String] = ["Shoshana", "Damari", "Ofra Haza"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: Table Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK: Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row number: \(indexPath.row), Text is: \(itemArray[indexPath.row])")
    
    
    // add checkbox to selected row
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
    } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    // change appearance of selected row
    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: add new items
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
                self.itemArray.append(textField.text!)
                print(self.itemArray)
                
                // reload 
                self.tableView.reloadData()
        }
        
        
        alert.addAction(action)
        
        // show popup
        present(alert, animated: true, completion: nil)
        //present(alert, animated: true, completion: nil)
    }
    
}

