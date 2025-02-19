import Foundation
import SwiftData
import CloudKit

/// `RemoteConfig` models the CloudKit-provided remote configuration options.
public struct RemoteConfig: Codable {
    public let openAiApiKey: String
    
    public init(openAiApiKey: String) {
        self.openAiApiKey = openAiApiKey
    }
    
    public init(record: CKRecord) throws {
        guard let apiKey = record["apiKeyOpenAI"] as? String else {
            throw RemoteConfigError.missingApiKey
        }
        self.init(openAiApiKey: apiKey)
    }
}
