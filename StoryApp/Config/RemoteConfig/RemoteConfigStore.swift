import Dependencies
import Foundation
import Observation

@Observable
final class RemoteConfigStore {
    @ObservationIgnored @Dependency(\.remoteConfigService) private var service
    
    private(set) var config: RemoteConfig?
    private(set) var isLoading = false
    
    @MainActor
    func fetch() async throws -> RemoteConfig {
        isLoading = true
        let loadedConfig = try await service.fetchRemoteConfig()
        self.config = loadedConfig
        isLoading = false
        
        return loadedConfig
    }
}

// MARK: - Dependencies
extension RemoteConfigStore: DependencyKey {
    static var liveValue: RemoteConfigStore { .init() }
}

extension DependencyValues {
    var remoteConfigStore: RemoteConfigStore {
        get { self[RemoteConfigStore.self] }
        set { self[RemoteConfigStore.self] = newValue }
    }
}
