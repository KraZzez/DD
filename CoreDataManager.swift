//
//  CoreDataManager.swift
//  DD
//
//  Created by Ludvig Krantzén on 2022-12-05.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    var moc = PersistenceController.shared.container.viewContext
    @Published var savedTaskObjects: [TaskObject] = []
    
    func fetchTaskObjects() {
        let request = NSFetchRequest<TaskObject>(entityName: "TaskObject")
        
        do {
            savedTaskObjects = try moc.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addPresetTaskObject(name: String, category: String, frequency: String) {
        let newTaskObject = TaskObject(context: moc)
        newTaskObject.name = name
        newTaskObject.points = 2
        newTaskObject.frequency = frequency
        newTaskObject.isComplete = false
        newTaskObject.category = category
        saveData()
    }
    
    func addTaskObject(name: String, category: String, frequency: String) {
        let newTaskObject = TaskObject(context: moc)
        newTaskObject.name = name
        newTaskObject.points = 1
        newTaskObject.frequency = frequency
        newTaskObject.isComplete = false
        newTaskObject.category = category
        saveData()
    }
    
    func deleteTaskObject(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedTaskObjects[index]
        moc.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try moc.save()
            fetchTaskObjects()
        } catch let error {
            print("Error saving \(error)")
        }
    }
}
