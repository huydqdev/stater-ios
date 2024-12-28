import SwiftUI
import Firebase

@main
struct StartIOSApp: App {
    @StateObject private var authManager = AuthenticationManager.shared
    
    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                MainTabView()
            } else {
                ContentView()
            }
        }
    }
} 