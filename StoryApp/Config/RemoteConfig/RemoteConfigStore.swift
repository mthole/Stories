import Dependencies
import Foundation
import Observation

@Observable
final class RemoteConfigStore {
    @ObservationIgnored @Dependency(\.remoteConfigService) private var service

    private(set) var config: RemoteConfig?
    private(set) var isLoading = false
    private(set) var error: Error?

    @MainActor
    func fetch() async {
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
    static var liveValue: RemoteConfigStore = .init()
}

extension DependencyValues {
    var remoteConfigStore: RemoteConfigStore {
        get { self[RemoteConfigStore.self] }
        set { self[RemoteConfigStore.self] = newValue }
    }
}
