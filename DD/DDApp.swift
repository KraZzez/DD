//
//  DDApp.swift
//  DD
//
//  Created by Ludvig Krantzén on 2022-12-05.
//

import SwiftUI

@main
struct DDApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
