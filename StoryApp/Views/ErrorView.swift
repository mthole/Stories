import SwiftUI

struct ErrorView: View {
    let error: Error
    let retry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
            
            Text("Something went wrong")
                .font(.headline)
            
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
            
            Button("Retry") {
                retry()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
} 
