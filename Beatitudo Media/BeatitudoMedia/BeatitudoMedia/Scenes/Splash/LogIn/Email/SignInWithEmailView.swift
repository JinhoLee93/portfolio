//
//  BeatitudoMediaLogInView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/18/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


class SignInWithEmailViewModel: ObservableObject {
    @Published var email    = ""
    @Published var password = ""
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No Email or password found.")
            
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SignInWithEmailView: View {
    @StateObject private var viewModel = SignInWithEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("이메일 주소를 입력해주세요.", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape( RoundedRectangle(cornerRadius: 10) )
            
            TextField("비밀번호를 입력해주세요.", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape( RoundedRectangle(cornerRadius: 10) )
            
            Button {
                viewModel.signIn()
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape( RoundedRectangle(cornerRadius: 10) )
            }
            
            Button {
                do {
                    try viewModel.signOut()
                } catch let error {
                    print(error)
                }
            } label: {
                Text("Forgot your password?")
                    .font(.system(size: 12))
            }
        }
        .padding()
        .navigationTitle("Sign In with Email")
    }
}

extension SignInWithEmailView {
    private func handleSignInButton() {
//        GIDSignIn.sharedInstance.signIn() { signInResult, error in
//            guard let result = signInResult else {
//                
//                return
//            }
//        }
    }
}

#Preview {
    SignInWithEmailView()
}
