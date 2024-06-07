//
//  SigningMethodButton.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import SwiftUI

struct SigningMethodButton: View {
    @EnvironmentObject private var viewModel: BeatitudoMediaSigningViewModel
    
    let method: String
    
    @Binding var showEmailSigningSheet: Bool
    @Binding var showSigningSheet: Bool
    @Binding var isUserSignedIn: Bool
    @Binding var isSigningIn: Bool
    @Binding var showProgressView: Bool
    
    var body: some View {
        Button {
            if method == "Email" {
                withAnimation(.easeInOut(duration: 0.25)) {
                    showEmailSigningSheet = true
                }
            } else if method == "Google" {
                Task {
                    do {
                        showProgressView = true
                        if !isSigningIn {
                            try await viewModel.signUpWithGoogle()
                        } else {
                            try await viewModel.signInWithGoogle()
                        }
                        withAnimation(.easeInOut(duration: 0.25)) {
                            isUserSignedIn = true
                        }
                        showProgressView = false
                    } catch {
                        showProgressView = false
                        print("\(error) occurred using Google Signing")
                    }
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
