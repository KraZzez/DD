//
//  ContentView.swift
//  DD
//
//  Created by Ludvig Krantzén on 2022-12-05.
//

import SwiftUI
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

struct ContentView: View {
    
    var coreDataManager = CoreDataManager.shared
    @State var taskObjectText: String = ""
    @State private var showNewTaskSheet = false
    @StateObject var viewModel = ViewModel()
    @State var selectedPriority: FrequencyPicker = .daily
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                PickerFrequency(selectedFrequency: $selectedPriority)
                    .padding(.horizontal)
                
                List {
                    ForEach(viewModel.dataArr) { task in
                        VStack {
                            Text(task.name ?? "No name")
                            Text(task.frequency ?? "No frequency")
                            Text("Points: \(task.points)")
                            Text(task.category ?? "No category")
                            if task.isComplete {
                                Text("Complete")
                            } else {
                                Text("Not Complete")
                            }
                        }
                    }
                    .onDelete(perform: coreDataManager.deleteTaskObject)
                }
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem {
                        Button {
                            showNewTaskSheet.toggle()
                        } label: {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            
                        } label: {
                            Image(systemName: "person.fill")
                        }
                        
                    }
                }
                .sheet(isPresented: $showNewTaskSheet) {
                    NewTaskObjectView()
                }
                Spacer()
            }
            .navigationTitle("TESTTT")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
