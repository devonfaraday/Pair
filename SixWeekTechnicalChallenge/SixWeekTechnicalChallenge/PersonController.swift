//
//  PersonController.swift
//  SixWeekTechnicalChallenge
//
//  Created by Christian McMullin on 3/10/17.
//  Copyright © 2017 Christian McMullin. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    static let shared = PersonController()
    
    var people: [Person] = []
    var pairs: [[Person]] {
        return addPairsFromPeople(arraysOfPeople: people)
    }
   
    init() {
        fetchFromPersistentStore()
    }
    
    func createPerson(withName name: String) {
        let person = Person(name: name)
        people.append(person)
        saveToPersistentStore()
    }
    
    
    func fetchFromPersistentStore() {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        people = (try? CoreDataStack.context.fetch(request)) ?? []
        
    }
    
    func saveRandomList() {
        people.random()
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let error {
            NSLog("Error: \(error.localizedDescription)\n Error Saving")
        }
        print("Saving was successful")
    }
    
    func addPairsFromPeople(arraysOfPeople: [Person]) -> [[Person]] {
        let splitSize = 2
        let sectionsOfPeople = stride(from: 0, to: arraysOfPeople.count, by: splitSize).map { Array(arraysOfPeople[$0..<min($0 + splitSize, arraysOfPeople.count)]) }
        return sectionsOfPeople
    }
    
    
}
extension Array {
    mutating func random() {
        for _ in 0..<20 { sort { (_,_) in arc4random() < arc4random() } }
    }
}
