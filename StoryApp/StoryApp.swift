import Dependencies
import StoryData
import SwiftData
import SwiftUI

@main
struct StoryApp: App {
    @State private var appState = AppState()
    private let cloudKitService = CloudKitService()
    
    var body: some Scene {
        WindowGroup {
            switch appState.loadingState {
            case .loading:
                LoadingView()
                    .task {
                        await appState.initialize()
                    }
                
            case .needsICloudAccount:
                ICloudSignInView()
                
            case .configError(let error):
                ErrorView(error: error, retry: {
                    Task {
                        await appState.initialize()
                    }
                })
                
            case .ready:
                if let apiKey = appState.apiKey {
                    MainAppView(apiKey: apiKey)
                        .modelContainer(cloudKitService.sharedModelContainer)
                }
            }
        }
    }
}
