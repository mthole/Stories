import SwiftData

public struct CloudKitMigrationPlan: SchemaMigrationPlan {
    public nonisolated(unsafe) static var schemas: [any VersionedSchema.Type] = []
    public nonisolated(unsafe) static var stages: [MigrationStage] = []

    public init() {}
}
