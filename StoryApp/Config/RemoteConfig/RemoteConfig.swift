import Foundation
import SwiftData
import CloudKit

/// `RemoteConfig` models the CloudKit-provided remote configuration options.
struct RemoteConfig: Codable {
    let openAiApiKey: String
    
    init(openAiApiKey: String) {
        self.openAiApiKey = openAiApiKey
    }
    
    init(record: CKRecord) throws {
        guard let apiKey = record["apiKeyOpenAI"] as? String else {
            throw RemoteConfigError.missingApiKey
        }
        self.init(openAiApiKey: apiKey)
    }
}
