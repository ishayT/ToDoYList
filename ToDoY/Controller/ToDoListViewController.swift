//
//  ViewController.swift
//  ToDoY
//
//  Created by Ishay on 2/11/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    //create the context from appDelgate singelton
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        saveItems()
        
      
        
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
                
                let newItem : Item = Item(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
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
        
        do {
            try context.save()
        } catch {
            print("Error saving item array: \(error)")
        }
    }
    
    func loadItems() {
        //you have to specify the data type of the request and the entity type
        let request : NSFetchRequest<Item> = Item.fetchRequest()

        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }

    }
}

