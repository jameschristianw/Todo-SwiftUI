//
//  TodoTest_SwiftUIApp.swift
//  TodoTest-SwiftUI
//
//  Created by James Christian Wira on 13/05/22.
//

import SwiftUI

@main
struct TodoTest_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
