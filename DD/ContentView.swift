//
//  ContentView.swift
//  DD
//
//  Created by Ludvig Krantzén on 2022-12-05.
//

import SwiftUI

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
                        HStack {
                            Button {
                                task.isComplete.toggle()
                            } label: {
                                if task.isComplete == true {
                                    Image(systemName: "circle.fill")
                                } else {
                                    Image(systemName: "circle")
                                }
                            }

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
