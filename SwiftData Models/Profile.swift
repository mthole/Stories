import Foundation
import SwiftData

/// `Profile` contains high-level context provided by the Reader for use in generating customized and relevant stories.
/// TODO: figure out how to structure the input, including allowing freeform additional context
/// TODO: will ultimately "output" to part of an LLM prompt, but there is probably an advantage to creating and storing it in a more structured manner
@Model
final class Profile {
    var timestamp: Date = Date.distantPast
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
