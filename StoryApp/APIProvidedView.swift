import OpenAI
import SwiftUI

struct APIProvidedView: View {
    @Binding var apiKey: String
    @StateObject var chatStore: ChatStore

    @Environment(\.idProviderValue) var idProvider
    @Environment(\.dateProviderValue) var dateProvider

    init(
        apiKey: Binding<String>,
        idProvider: @escaping () -> String
    ) {
        _apiKey = apiKey
        _chatStore = StateObject(
            wrappedValue: ChatStore(
                openAIClient: OpenAI(apiToken: apiKey.wrappedValue),
                idProvider: idProvider
            )
        )
    }

    var body: some View {
        ContentView(
            chatStore: chatStore
        )
        .onChange(of: apiKey) { newApiKey in
            let client = OpenAI(apiToken: newApiKey)
            chatStore.openAIClient = client
        }
    }
}
