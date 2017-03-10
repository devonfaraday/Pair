//
//  PersonListTableViewController.swift
//  SixWeekTechnicalChallenge
//
//  Created by Christian McMullin on 3/10/17.
//  Copyright © 2017 Christian McMullin. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    
    
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
    
}
