//
//  NewTaskObjectView.swift
//  DD
//
//  Created by Ludvig Krantzén on 2022-12-05.
//

import SwiftUI

struct NewTaskObjectView: View {
    
    @Environment(\.dismiss) private var dismiss
    var coreDataManager = CoreDataManager.shared
    @State var taskObjectText: String = ""
    @State var selectedPriority: FrequencyPicker = .daily
    @State var selectedCategory = "Fitness"
    
    @State var selectedPresetCategory = "Test"
    @State var showPresetTasks = false
    @State var showPresetTasksCategories = false
    @State var selectedPresetItem = "Go to the gym"
    
    @State var categoryToImage = CategoryToImage()
    
    
    let presetTasks: [TaskTemplate] = [
    TaskTemplate(name: "Go to the gym", category: "Fitness"),
    TaskTemplate(name: "Do Yoga", category: "Fitness"),
    TaskTemplate(name: "Stretch", category: "Fitness"),
    TaskTemplate(name: "Go for a run", category: "Fitness"),
    TaskTemplate(name: "Go for a walk", category: "Fitness"),
    TaskTemplate(name: "Do body weight exersices", category: "Fitness"),
    TaskTemplate(name: "Buy Groceries", category: "Chores"),
    TaskTemplate(name: "Clean the apartment", category: "Chores"),
    TaskTemplate(name: "Clean your room", category: "Chores"),
    TaskTemplate(name: "Clean the house", category: "Chores"),
    TaskTemplate(name: "Do the laundry", category: "Chores"),
    TaskTemplate(name: "Wash the car", category: "Chores"),
    TaskTemplate(name: "Take out the trash", category: "Chores"),
    TaskTemplate(name: "Pay the bills", category: "Chores"),
    TaskTemplate(name: "Walk the dog", category: "Health"),
    TaskTemplate(name: "Go for a walk", category: "Health"),
    TaskTemplate(name: "Call someone important", category: "Health"),
    TaskTemplate(name: "Write in your gratitude journal", category: "Health"),
    TaskTemplate(name: "Meditate", category: "Health"),
    TaskTemplate(name: "Eat a fruit", category: "Health"),
    TaskTemplate(name: "Cook a meal", category: "Cooking"),
    TaskTemplate(name: "Meal prep", category: "Cooking"),
    TaskTemplate(name: "Bake bread", category: "Cooking"),
    TaskTemplate(name: "Make dessert", category: "Cooking"),
    TaskTemplate(name: "Read", category: "Study"),
    TaskTemplate(name: "Study one hour", category: "Study"),
    TaskTemplate(name: "Study for a test", category: "Study"),
    TaskTemplate(name: "Go to School", category: "Study"),
    TaskTemplate(name: "Watch a movie", category: "Recreational"),
    TaskTemplate(name: "Watch an episode of a show", category: "Recreational"),
    TaskTemplate(name: "Play a video game", category: "Recreational"),
    TaskTemplate(name: "Play a board game", category: "Recreational"),
    TaskTemplate(name: "Listen to music", category: "Recreational"),
    TaskTemplate(name: "Play music", category: "Recreational"),
    ]

    let categories = ["Fitness", "Chores", "Cooking", "Study", "Recreational"]
    
    var body: some View {
        VStack(spacing: 20) {
            PickerFrequency(selectedFrequency: $selectedPriority)
                .padding(.horizontal)
            if !showPresetTasksCategories {
                HStack {
                    TextField("Add taskobject here...", text: $taskObjectText)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(.gray)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Picker("", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            
            Button {
                showPresetTasksCategories.toggle()
                showPresetTasks = false
            } label: {
                Text("Choose a preset category!")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(10)
            .padding(.horizontal)

            if showPresetTasksCategories {
                ScrollView(.horizontal, showsIndicators: true, content: {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Button {
                                showPresetTasks = true
                                selectedPresetCategory = category
                            } label: {
                                VStack{
                                    Text(category)
                                    Image(systemName: "\(categoryToImage.getCategoryImage(category: category))")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                }
                            }
                        }
                    }
                })
            }
            
            if showPresetTasks {
                Picker("", selection: $selectedPresetItem) {
                    ForEach(presetTasks) { task in
                        if task.category == selectedPresetCategory{
                            Text(task.name)
                                .tag(task.name)
                        }
                    }
                }
                .pickerStyle(.wheel)
            }
             
            Spacer()
            Button {
                if showPresetTasks {
                    coreDataManager.addPresetTaskObject(name: selectedPresetItem, category: selectedPresetCategory, frequency: selectedPriority.rawValue)
                } else if !showPresetTasksCategories {
                    guard !taskObjectText.isEmpty else { return }
                    coreDataManager.addTaskObject(name: taskObjectText, category: selectedCategory, frequency: selectedPriority.rawValue)
                    dismiss()
                } else { return }
            } label: {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                
            }
            .padding(.horizontal)
        }
        .padding(.top)
    }
}

struct NewTaskObjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskObjectView()
    }
}


struct TaskTemplate: Identifiable {
    var id = UUID()
    
    var name: String
    var category: String
}
