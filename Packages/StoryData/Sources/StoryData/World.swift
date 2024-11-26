import Foundation
import SwiftData

/// A `World` describes the shared story narratives used for each of the stories within it.
/// TODO: Make that ^ more thought out
public typealias World = WorldSchemaV1.World

public enum WorldSchemaV1: VersionedSchema {
    nonisolated(unsafe) public static var versionIdentifier = Schema.Version(0, 0, 1)
    
    public static var models: [any PersistentModel.Type] {
        [World.self]
    }
    
    @Model
    public final class World {
        public var freeformText: String = ""
        
        public init(freeformText: String) {
            self.freeformText = freeformText
        }
    }
}

