import CloudKit
import Foundation
import SwiftData

public final class CloudKitService {
    public init() {}

    public var sharedModelContainer: ModelContainer = {
        let version = Schema.Version(0, 0, 1)

        let models: [any PersistentModel.Type] = [Profile.self, World.self, Story.self]

        let schema = Schema(models, version: version)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, cloudKitDatabase: .automatic)

        do {
            return try ModelContainer(for: schema, migrationPlan: CloudKitMigrationPlan.self, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}

//
// @MainActor
// public final class RemoteConfigurationManager {
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
// }
