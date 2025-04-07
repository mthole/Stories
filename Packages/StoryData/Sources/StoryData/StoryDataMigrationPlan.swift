import SwiftData

struct StoryDataMigrationPlan: SchemaMigrationPlan {
    nonisolated(unsafe) static var schemas: [any VersionedSchema.Type] = []
    nonisolated(unsafe) static var stages: [MigrationStage] = []
}
