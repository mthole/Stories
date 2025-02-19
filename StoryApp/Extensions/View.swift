import SwiftUI

public extension View {
    @inlinable func navigationTitle(_ titleKey: LocalizedStringKey, selectedModel: Binding<String>) -> some View {
        navigationTitle(titleKey)
            .safeAreaInset(edge: .top) {
                HStack {
                    Text(
                        "Model: \(selectedModel.wrappedValue)"
                    )
                    .font(.caption)
                    .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
    }

    @inlinable func modelSelect(selectedModel: Binding<String>, models: [String], showsModelSelectionSheet: Binding<Bool>, help: String) -> some View {
        toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showsModelSelectionSheet.wrappedValue.toggle()
                }) {
                    Image(systemName: "cpu")
                }
            }
        }
        .confirmationDialog(
            "Select model",
            isPresented: showsModelSelectionSheet,
            titleVisibility: .visible,
            actions: {
                ForEach(models, id: \.self) { (model: String) in
                    Button {
                        selectedModel.wrappedValue = model
                    } label: {
                        Text(model)
                    }
                }

                Button("Cancel", role: .cancel) {
                    showsModelSelectionSheet.wrappedValue = false
                }
            },
            message: {
                Text(
                    "View \(help) for details"
                )
                .font(.caption)
            }
        )
    }
}
