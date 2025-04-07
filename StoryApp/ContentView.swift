//
//  ContentView.swift
//  StoryApp
//
//  Created by Michael Thole on 11/24/24.
//

import OpenAI
import StoryData
import SwiftData
import SwiftUI

struct ContentView: View {
    @ObservedObject var chatStore: ChatStore
    @Environment(\.idProviderValue) var idProvider
    @Environment(\.modelContext) private var modelContext
    @State private var isShowingProfile = false

    @Query private var items: [Story]

    var body: some View {
        ChatView(store: chatStore)
            .sheet(isPresented: $isShowingProfile) {
                // TODO: We'll create a ProfileView next
                Text("Profile View Coming Soon")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isShowingProfile = true
                    }) {
                        Image(systemName: "person.circle")
                    }
                }
            }
    }

    private func addItem() {
        withAnimation {
            let newStory = Story(freeformText: "new story here")
            modelContext.insert(newStory)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView(chatStore: ChatStore(
        openAIClient: OpenAI(apiToken: "preview-mock-key"),
        idProvider: { UUID().uuidString }
    ))
    .modelContainer(for: Story.self, inMemory: true)
}
