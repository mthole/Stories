import CloudKit
import Dependencies
import Foundation
import SwiftData

struct RemoteConfigService {
    var fetchRemoteConfig: @Sendable () async throws -> RemoteConfig
}

// MARK: - Dependencies
extension RemoteConfigService: DependencyKey {
    static var liveValue: Self {
        @Dependency(\.appConfig) var config
        
        let container = CKContainer(identifier: config.iCloudContainerIdentifier)
        let database = container.publicCloudDatabase
        
        return Self(fetchRemoteConfig: { try await fetchConfig(database: database, recordName: config.remoteConfigRecordName) })
    }
    
    private static func fetchConfig(database: CKDatabase, recordName: String) async throws -> RemoteConfig {
        let recordID = CKRecord.ID(recordName: recordName)
        let results = try await database.records(for: [recordID])
        
        guard let result = results[recordID],
              case let .success(record) = result
        else {
            throw RemoteConfigError.notFound
        }
        
        return try RemoteConfig(record: record)
    }
}

extension DependencyValues {
    var remoteConfigService: RemoteConfigService {
        get { self[RemoteConfigService.self] }
        set { self[RemoteConfigService.self] = newValue }
    }
}
