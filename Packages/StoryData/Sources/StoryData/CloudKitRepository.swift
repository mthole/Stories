import CloudKit
import Foundation
import SwiftData

public final class CloudKitRepository {
    
    public init() {}
    
    public var sharedModelContainer: ModelContainer = {
        let version = Schema.Version(0, 0, 1)

        let models: [any PersistentModel.Type] = {
            [RemoteConfiguration.self,
             Profile.self,
             World.self,
             Story.self
            ]
        }()
        
        let schema = Schema(models, version: version)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, cloudKitDatabase: .automatic)
        
        do {
            return try ModelContainer(for: schema, migrationPlan: CloudKitMigrationPlan.self, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    public func fetchRemoteConfiguration() async throws -> RemoteConfiguration {
//        // First try to fetch from local storage
//        let descriptor = FetchDescriptor<RemoteConfiguration>()
//        if let existingConfig = try? sharedModelContainer.mainContext.fetch(descriptor).first {
//            return existingConfig
//        }
//        
//        // If not found locally, fetch from CloudKit
//        let database = CKContainer.default().publicCloudDatabase
//        let query = CKQuery(recordType: "RemoteConfigurationV1", predicate: NSPredicate(value: true))
//        
//        let (results, _) = try await database.records(matching: query)
//        
//        guard let firstResult = results.first,
//              case .success(let record) = firstResult.1 else {
//            throw NSError(domain: "RemoteConfiguration",
//                         code: 404,
//                         userInfo: [NSLocalizedDescriptionKey: "No configuration found"])
//        }
//        
//        guard let openAiApiKey = record["openAiApiKey"] as? String else {
//            throw NSError(domain: "RemoteConfiguration",
//                         code: 500,
//                         userInfo: [NSLocalizedDescriptionKey: "Missing API Key"])
//        }
//        
//        // Create and save the configuration locally
//        let config = RemoteConfiguration(openAiApiKey: openAiApiKey)
//        sharedModelContainer.mainContext.insert(config)
//        try sharedModelContainer.mainContext.save()
//        
//        return config
        return RemoteConfiguration(openAiApiKey: "stub")
    }
}


//
//@MainActor
//public final class RemoteConfigurationManager {
//    public static let shared = RemoteConfigurationManager()
//
//    private let database = CKContainer.default().publicCloudDatabase
//
//    private init() {}
//
//    public func fetchRemoteConfiguration() async throws -> RemoteConfiguration {
//        let query = CKQuery(recordType: "RemoteConfiguration", predicate: NSPredicate(value: true))
//
//        // Fetch all records, assuming there's only one RemoteConfiguration
//        let (results, _) = try await database.records(matching: query)
//        
//        // Get the first result and handle the Result type properly
//        guard let firstResult = results.first,
//              case .success(let record) = firstResult.1 else {
//            throw NSError(domain: "RemoteConfiguration", code: 404, userInfo: [NSLocalizedDescriptionKey: "No configuration found"])
//        }
//
//        // Map the CKRecord to your RemoteConfiguration model
//        guard let openAiApiKey = record["openAiApiKey"] as? String else {
//            throw NSError(domain: "RemoteConfiguration", code: 500, userInfo: [NSLocalizedDescriptionKey: "Missing API Key"])
//        }
//
//        return RemoteConfiguration(openAiApiKey: openAiApiKey)
//    }
//}
