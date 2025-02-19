//
//  StoryApp.swift
//  StoryApp
//
//  Created by Michael Thole on 11/24/24.
//

import SwiftUI
import SwiftData
import StoryData
import Dependencies

@main
struct StoryApp: App {
    @AppStorage("apiKey") var apiKey: String = ""
    
    @Dependency(\.remoteConfigStore) var remoteConfigStore
    
    let idProvider: () -> String
    let dateProvider: () -> Date
    
//    @StateObject private var remoteConfigStore = RemoteConfigStore(service: RemoteConfigService.liveValue)
    
    init() {
        self.idProvider = {
            UUID().uuidString
        }
        self.dateProvider = Date.init
    }

    var body: some Scene {
        WindowGroup {
            APIProvidedView(apiKey: $apiKey, idProvider: idProvider)
                .task {
                    await remoteConfigStore.fetch()
                    NSLog("*** fetched \(remoteConfigStore.config)")
                }
//                .onChange(of: remoteConfigStore.configuration) { config in
//                    if let config = config {
//                        apiKey = config.openAiApiKey
//                    }
//                }
        }
    }
}
