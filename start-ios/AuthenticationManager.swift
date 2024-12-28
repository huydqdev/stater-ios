import Firebase
import GoogleSignIn
import FacebookLogin

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    static let shared = AuthenticationManager()
    
    init() {
        setupFirebase()
    }
    
    private func setupFirebase() {
        FirebaseApp.configure()
        
        if let user = Auth.auth().currentUser {
            self.isAuthenticated = true
            self.currentUser = user
        }
    }
    
    func signInWithGoogle() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else { return }
        
        let result = try await GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController)
        let credential = GoogleAuthProvider.credential(withIDToken: result.idToken?.tokenString ?? "",
                                                     accessToken: result.accessToken.tokenString)
        
        let authResult = try await Auth.auth().signIn(with: credential)
        self.currentUser = authResult.user
        self.isAuthenticated = true
    }
    
    func signInWithFacebook() async throws {
        let loginManager = LoginManager()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else { return }
        
        return try await withCheckedThrowingContinuation { continuation in
            loginManager.logIn(permissions: ["public_profile", "email"], from: rootViewController) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let accessToken = AccessToken.current else {
                    continuation.resume(throwing: NSError(domain: "", code: -1))
                    return
                }
                
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                Task {
                    do {
                        let authResult = try await Auth.auth().signIn(with: credential)
                        self.currentUser = authResult.user
                        self.isAuthenticated = true
                        continuation.resume()
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        self.isAuthenticated = false
        self.currentUser = nil
    }
} 