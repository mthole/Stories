import SwiftUI

struct MainAppView: View {
    let apiKey: String
    
    var body: some View {
        APIProvidedView(apiKey: .constant(apiKey), idProvider: { UUID().uuidString })
    }
} 
