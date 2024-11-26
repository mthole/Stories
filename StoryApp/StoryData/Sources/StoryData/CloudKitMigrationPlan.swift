import SwiftData

public struct CloudKitMigrationPlan: SchemaMigrationPlan {
    nonisolated(unsafe) public static var schemas: [any VersionedSchema.Type] = []
    nonisolated(unsafe) public static var stages: [MigrationStage] = []
    
    public init() {}
}
