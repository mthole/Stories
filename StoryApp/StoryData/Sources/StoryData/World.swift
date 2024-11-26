import Foundation
import SwiftData

/// A `World` describes the shared story narratives used for each of the stories within it.
/// TODO: Make that ^ more thought out
/// TOOD: Maybe I should just go `Profile` / `World` / `Story`, but namespace them appropraitely in a struct or library?
@Model
final class World {
    var timestamp: Date = Date.distantPast
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
