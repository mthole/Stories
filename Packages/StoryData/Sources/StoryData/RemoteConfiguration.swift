import Foundation
import SwiftData

/// `RemoteConfiguration` models the CloudKit-provided remote configuration options.
public typealias RemoteConfiguration = RemoteConfigurationSchemaV1.RemoteConfiguration


public enum RemoteConfigurationSchemaV1: VersionedSchema {
    nonisolated(unsafe) public static var versionIdentifier = Schema.Version(0, 0, 1)

    public static var models: [any PersistentModel.Type] {
        [RemoteConfiguration.self]
    }

    @Model
    public final class RemoteConfiguration {
        public var openAiApiKey: String = ""
        
        public init(openAiApiKey: String) {
            self.openAiApiKey = openAiApiKey
        }
    }
}

