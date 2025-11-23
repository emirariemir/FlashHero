//
//  FlashHeroApp.swift
//  FlashHero
//
//  Created by Emir Arı on 5.11.2025.
//

import SwiftUI
import CoreData

@main
struct FlashHeroApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) {
            persistenceController.save()
        }
    }
}
