import Foundation
import SwiftData

/// `Profile` contains high-level context provided by the Reader for use in generating customized and relevant stories.
/// TODO: figure out how to structure the input, including allowing freeform additional context
/// TODO: will ultimately "output" to part of an LLM prompt, but there is probably an advantage to creating and storing it in a more structured manner

public typealias Profile = ProfileSchemaV1.Profile

public enum ProfileSchemaV1: VersionedSchema {
    nonisolated(unsafe) public static var versionIdentifier = Schema.Version(0, 0, 1)
    
    public static var models: [any PersistentModel.Type] {
        [Profile.self]
    }
    
    @Model
    public final class Profile {
        public var freeformText: String = ""
        
        public init(freeformText: String) {
            self.freeformText = freeformText
        }
    }
}

