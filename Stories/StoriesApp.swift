//
//  StoriesApp.swift
//  Stories
//
//  Created by Michael Thole on 11/24/24.
//

import SwiftUI
import SwiftData

@main
struct StoriesApp: App {
    @AppStorage("apiKey") var apiKey: String = ""

    let idProvider: () -> String
    let dateProvider: () -> Date
    
    init() {
        self.idProvider = {
            UUID().uuidString
        }
        self.dateProvider = Date.init
    }

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, cloudKitDatabase: .automatic)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            Group {
                APIProvidedView(apiKey: $apiKey, idProvider: idProvider)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
