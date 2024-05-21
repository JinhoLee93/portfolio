//
//  LogInMethodButton.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor
class LogInButtonViewModel: ObservableObject {
    
    
    func signInWithGoogle() async throws {
        guard let topVC = Utils.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        let authenticDataResultModel = try await AuthenticationManager.shared.signInWithGoogle(gidSignInResult: gidSignInResult)
    }
}

struct LogInMethodButton: View {
    @StateObject private var viewModel = LogInButtonViewModel()
    
    let method: String
    
    @Binding var showEmailSigningSheet: Bool
    @Binding var isSigningIn: Bool
    
    var body: some View {
        Button {
            if method == "Email" {
                showEmailSigningSheet = true
            } else if method == "Google" {
                Task {
                    try await viewModel.signInWithGoogle()
                }
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.adaptiveSignInButton)
                
                HStack {
                    Image("\(method)SignIn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 10))
                    
                    Spacer()
                }
                
                Text(isSigningIn ? "\(method)로 로그인하기" : "\(method)로 가입하기")
                    .font(.system(size: 16))
                    .foregroundStyle(.adaptiveText)
                    .frame(alignment: .center)
                    .bold()
            }
            .frame(height: 44)
        }
    }
}
//
//#Preview {
//    LogInMethodButton(method: "Google")
//}
