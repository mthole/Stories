//
//  ContentView.swift
//  Stories
//
//  Created by Michael Thole on 11/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var chatStore: ChatStore
    @Environment(\.idProviderValue) var idProvider
    
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab = 0

    @Query private var items: [Item]
    
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
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
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
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
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

//#Preview {
//    ContentView(chatStore: ChatStore)
//        .modelContainer(for: Item.self, inMemory: true)
//}
