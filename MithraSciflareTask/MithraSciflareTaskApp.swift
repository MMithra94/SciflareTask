//
//  MithraSciflareTaskApp.swift
//  MithraSciflareTask
//
//  Created by Mithra Mohan on 22/02/24.
//

import SwiftUI

@main
struct MithraSciflareTaskApp: App {
    // MARK: Core data
    @StateObject private var manager: DataManager = DataManager()
    
    
    var body: some Scene {
        WindowGroup {
            PersonListView()
            // MARK: Core data
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
