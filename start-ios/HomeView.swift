import SwiftUI

struct HomeView: View {
    let learningItems = ["Learn Swift Fundamentals", 
                        "Build Your First iOS App", 
                        "Master SwiftUI Layouts", 
                        "Working with Networking", 
                        "Understanding Core Data"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Text("Logo")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "bell.fill")
                            .font(.title2)
                    }
                }
                .padding()
                
                // Learning Items List
                List(learningItems, id: \.self) { item in
                    Text(item)
                        .padding(.vertical, 8)
                }
                
                // Logout Button
                Button(action: handleLogout) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
    
    private func handleLogout() {
        do {
            try AuthenticationManager.shared.signOut()
        } catch {
            print("Error signing out: \(error)")
        }
    }
} 