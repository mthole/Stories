//
//  StoryApp.swift
//  StoryApp
//
//  Created by Michael Thole on 11/24/24.
//

import SwiftUI
import SwiftData
import StoryData

@main
struct StoryApp: App {
    @AppStorage("apiKey") var apiKey: String = ""
    @State private var cloudKitRepository: CloudKitRepository

    let idProvider: () -> String
    let dateProvider: () -> Date
    
    init() {
        self.idProvider = {
            UUID().uuidString
        }
        self.dateProvider = Date.init
        self.cloudKitRepository = CloudKitRepository()
    }


    var body: some Scene {
        WindowGroup {
            Group {
                APIProvidedView(apiKey: $apiKey, idProvider: idProvider)
            }
            .onAppear(perform: {
                Task {
                    let remoteConfiguration = try await cloudKitRepository.fetchRemoteConfiguration()
                    print("*** remoteConfiguration: \(remoteConfiguration)")
                }
            })
        }
        .modelContainer(cloudKitRepository.sharedModelContainer)
    }
}
