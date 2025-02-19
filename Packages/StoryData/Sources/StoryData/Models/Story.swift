import Foundation
import SwiftData

/// A single `Story`, set within a `StoryWorld`. Primarily generated via AI and then stored here with appropriate context.
/// TODO: How to link stories and worlds, etc.
/// TODO: How to link artwork?
/// TODO: How to like TTS audio caches, etc
public typealias Story = StorySchemaV1.Story

public enum StorySchemaV1: VersionedSchema {
    public nonisolated(unsafe) static var versionIdentifier = Schema.Version(0, 0, 1)

    public static var models: [any PersistentModel.Type] {
        [Story.self]
    }

    @Model
    public final class Story {
        public var freeformText: String = ""

        public init(freeformText: String) {
            self.freeformText = freeformText
        }
    }
}
