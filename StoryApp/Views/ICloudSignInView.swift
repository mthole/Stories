import SwiftUI

// TODO: Can listen for CKAccountChanged notification and reload appropriately?
struct ICloudSignInView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "icloud.slash")
                .font(.system(size: 50))
            
            Text("iCloud Account Required")
                .font(.headline)
            
            Text("Please sign in to iCloud in Settings to use this app.")
                .multilineTextAlignment(.center)
            
            Button("Open Settings") {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
} 
