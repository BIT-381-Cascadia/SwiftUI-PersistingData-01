//
//  SwiftUI_PersistingData_01App.swift
//  SwiftUI-PersistingData-01
//
//  Created by Mike Panitz on 4/27/21.
//

import SwiftUI

@main
struct SwiftUI_PersistingData_01App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
