import CloudKit
import Foundation
import SwiftData
import Dependencies

struct RemoteConfigService {
    var fetchRemoteConfig: @Sendable () async throws -> RemoteConfig
    
    private let container: CKContainer
    private let database: CKDatabase
}

extension RemoteConfigService: DependencyKey {
    static var liveValue: RemoteConfigService {
        @Dependency(\.appConfig) var config
        
        let container = CKContainer(identifier: config.iCloudContainerIdentifier)
        let database = container.publicCloudDatabase
        
        return Self(fetchRemoteConfig: {
            let recordID = CKRecord.ID(recordName: config.remoteConfigRecordName)
            let results = try await database.records(for: [recordID])
            
            guard let result = results[recordID],
                  case .success(let record) = result else {
                throw RemoteConfigError.notFound
            }
            
            return try RemoteConfig(record: record)
        }, container: container, database: database)
    }
}

extension DependencyValues {
    var remoteConfigService: RemoteConfigService {
        get { self[RemoteConfigService.self] }
        set { self[RemoteConfigService.self] = newValue }
    }
}
