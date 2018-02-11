//
//  ViewController.swift
//  ToDoY
//
//  Created by Ishay on 2/11/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray : [String] = ["Shoshana", "Damari", "Ofra Haza"]
    
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
}

