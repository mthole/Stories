import Foundation
import SwiftData

/// A single `Story`, set within a `StoryWorld`. Primarily generated via AI and then stored here with appropriate context.
/// TODO: How to link stories and worlds, etc.
/// TODO: How to link artwork?
/// TODO: How to like TTS audio caches, etc
@Model
final class Story {
    var timestamp: Date = Date.distantPast
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
