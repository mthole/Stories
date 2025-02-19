import Dependencies

public struct AppConfig {
    /// The unique identifier for the app's iCloud container used for CloudKit storage
    let iCloudContainerIdentifier: String
    /// The record name used to store and retrieve remote configuration data in CloudKit
    let remoteConfigRecordName: String
}

extension AppConfig: DependencyKey {
    public static var liveValue: AppConfig {
        AppConfig(
            iCloudContainerIdentifier: "iCloud.mthole.com.stories.first-container",
            remoteConfigRecordName: "default_config"
        )
    }
}

public extension DependencyValues {
    var appConfig: AppConfig {
        get { self[AppConfig.self] }
        set { self[AppConfig.self] = newValue }
    }
}
