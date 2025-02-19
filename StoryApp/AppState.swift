import CloudKit
import Foundation
import Observation
import Dependencies

@Observable
final class AppState {
    enum LoadingState {
        case loading
        case needsICloudAccount
        case configError(Error)
        case ready
    }
    
    @ObservationIgnored @Dependency(\.remoteConfigStore) private var remoteConfigStore
    
    private(set) var loadingState: LoadingState = .loading
    private(set) var apiKey: String?
    
    @MainActor
    func initialize() async {
        do {
            #if !targetEnvironment(simulator)
            let status = try await CKContainer.default().accountStatus()
            guard status == .available else {
                loadingState = .needsICloudAccount
                return
            }
            #endif
            
            let config = try await remoteConfigStore.fetch()
            apiKey = config.openAiApiKey
            loadingState = .ready
        } catch {
            loadingState = .configError(error)
        }
    }
} 
