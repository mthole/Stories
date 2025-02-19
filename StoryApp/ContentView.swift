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
    @State private var selectedTab = 0

    @Query private var items: [Story]

    var body: some View {
        TabView(selection: $selectedTab) {
            ChatView(
                store: chatStore
            )
            .tabItem {
                Label("Chats", systemImage: "message")
            }

            NavigationSplitView {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Story: \(item.freeformText)")
                        } label: {
                            Text("Story: \(item.freeformText)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            } detail: {
                Text("Select an item")
            }
            .tabItem {
                Label("Items", systemImage: "message")
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
