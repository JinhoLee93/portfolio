//
//  AuthenticationManager.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/19/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private let actionCodeSettings: ActionCodeSettings
    
    private init() { 
        actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.handleCodeInApp = true
    }
    
    private func configureActionCodeSettings(email: String) {
        actionCodeSettings.url = URL(string: "https://beatitudo-media-d62da.firebaseapp.com/?email=\(email)")
    }
}

// MARK: - Google
extension AuthenticationManager {
    func signInWithGoogle(gidSignInResult: GIDSignInResult) async throws -> AuthDataResultModel {
        let user = gidSignInResult.user
        guard let idToken = user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = user.accessToken.tokenString
        let authCredential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: accessToken)
        
        return try await signIn(authCredential: authCredential)
    }
    
    @MainActor
    func signInWithGoogle() async throws -> AuthDataResultModel {
        guard let topVC = Utils.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        let authDataResultModel = try await AuthenticationManager.shared.signInWithGoogle(gidSignInResult: gidSignInResult)
        
        return authDataResultModel
    }
    
    private func signIn(authCredential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: authCredential)
        
        return AuthDataResultModel(user: authDataResult.user)
    }
}

// MARK: - Email
extension AuthenticationManager {
    func signUpUserWithEmailandPassword(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signInUserWithEmailAndPassword(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func fetchAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
