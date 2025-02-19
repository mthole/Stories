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
