import Foundation
import Dependencies
import Observation

@Observable
public final class RemoteConfigStore {
    @ObservationIgnored @Dependency(\.remoteConfigService) private var service
    
    public private(set) var config: RemoteConfig?
    public private(set) var isLoading = false
    public private(set) var error: Error?
    
    @MainActor
    public func fetch() async {
        isLoading = true
        error = nil
        
        do {
            config = try await service.fetchRemoteConfig()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}

// MARK: - Dependencies

extension RemoteConfigStore: DependencyKey {
    public static var liveValue: RemoteConfigStore = RemoteConfigStore()
}

extension DependencyValues {
    public var remoteConfigStore: RemoteConfigStore {
        get { self[RemoteConfigStore.self] }
        set { self[RemoteConfigStore.self] = newValue }
    }
}

