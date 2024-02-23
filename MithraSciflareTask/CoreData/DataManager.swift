//
//  DataManager.swift
//  MithraSciflareTask
//
//  Created by Mithra Mohan on 22/02/24.
//

import CoreData
import Foundation

class DataManager: NSObject, ObservableObject {
    @Published var personSaved: [PersonData] = [PersonData]()

    let container: NSPersistentContainer = NSPersistentContainer(name: "PersonData")
    
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}
