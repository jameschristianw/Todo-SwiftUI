//
//  Persistence.swift
//  TodoTest-SwiftUI
//
//  Created by James Christian Wira on 13/05/22.
//

import CoreData

struct DataController {
    let container = NSPersistentContainer(name: "TodoContainer")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Init CoreData Error => \(error.localizedDescription)")
            }
        }
    }
}
