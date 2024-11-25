import Foundation
import OpenAI

struct Message {
    var id: String
    var role: ChatQuery.ChatCompletionMessageParam.Role
    var content: String
    var createdAt: Date
}

extension Message: Equatable, Codable, Hashable, Identifiable {}
