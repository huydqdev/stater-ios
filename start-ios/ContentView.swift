import SwiftUI

struct ContentView: View {
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome")
                .font(.largeTitle)
                .padding(.bottom, 50)
            
            Button(action: handleFacebookLogin) {
                HStack {
                    Image(systemName: "f.square.fill")
                    Text("Continue with Facebook")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Button(action: handleGoogleLogin) {
                HStack {
                    Image(systemName: "g.circle.fill")
                    Text("Continue with Google")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func handleFacebookLogin() {
        Task {
//            do {
//                try await authManager.signInWithFacebook()
//            } catch {
//                showError = true
//                errorMessage = error.localizedDescription
//            }
        }
    }
    
    private func handleGoogleLogin() {
        Task {
//            do {
//                try await authManager.signInWithGoogle()
//            } catch {
//                showError = true
//                errorMessage = error.localizedDescription
//            }
        }
    }
}

#Preview {
    ContentView()
}
