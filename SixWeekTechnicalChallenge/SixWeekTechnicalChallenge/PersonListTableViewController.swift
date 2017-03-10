//
//  PersonListTableViewController.swift
//  SixWeekTechnicalChallenge
//
//  Created by Christian McMullin on 3/10/17.
//  Copyright © 2017 Christian McMullin. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \([section + 1][0])"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if PersonController.shared.people.count % 2 == 0 {
            return PersonController.shared.people.count / 2
        } else {
            return (PersonController.shared.people.count + 1) / 2
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.pairs[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        let person = PersonController.shared.pairs[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    @IBAction func randomize(_ sender: Any) {
        PersonController.shared.people.random()
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        addAlertController()
    }
    
    func addAlertController() {
        let alertController = UIAlertController(title: "Add Name", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Full Name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let textFields = alertController.textFields,
                let nameTextField = textFields.first,
                let name = nameTextField.text, !name.isEmpty else { return }
                PersonController.shared.createPerson(withName: name)
                let person = Person(name: name)
                PersonController.shared.people.append(person)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
