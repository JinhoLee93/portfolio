//
//  BeatitudoMediaSigningView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import SwiftUI

struct BeatitudoMediaSigningView: View {
    @StateObject private var viewModel = BeatitudoMediaSigningViewModel()
    
    @Binding var showSigningSheet: Bool
    @Binding var isUserSignedIn: Bool
    
    @State var showEmailSigningPage: Bool     = false
    @State var isSigningIn: Bool              = false
    @State private var showProgressView: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(showSigningSheet ? 0.4 : 0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showSigningSheet = false
                    }
                    
                    Task {
                        try await Task.sleep(for: .seconds(0.25))
                        
                        isSigningIn = false
                    }
                }
            
            BeatitudoMediaProgressView()
                .opacity(showProgressView ? 1 : 0)
                .zIndex(1)
                
            
            if showSigningSheet {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(.adaptiveBackground)
                    
                    VStack {
                        Text("Beatitudo Media에 가입하고, 소통하세요.")
                            .padding(.top, 25)
                            .padding(.bottom, 25)
                        
                        ForEach(viewModel.getSigningMethods(), id: \.self) { method in
                            SigningMethodButton(method: method, showEmailSigningSheet: $showEmailSigningPage, showSigningSheet: $showSigningSheet, isUserSignedIn: $isUserSignedIn, isSigningIn: $isSigningIn, showProgressView: $showProgressView)
                                .environmentObject(viewModel)
                        }
                        
                        HStack {
                            Text(isSigningIn ? "Beatitudo Media 계정이 없으신가요?" : "이미 Beatitudo Media 계정이 있으신가요?")
                                .foregroundStyle(.adaptiveText)
                                .font(.system(size: 14))
                            
                            Button {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    isSigningIn.toggle()
                                }
                            } label: {
                                Text(isSigningIn ? "가입하기" : "로그인하기")
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.top, 25)
                        .padding(.bottom, 25)
                        
                        Spacer()
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                .frame(height: 170 + CGFloat(50 * viewModel.getSigningMethodsCount()))
                .transition(.move(edge: .bottom))
                .zIndex(0.5)
                
                if isSigningIn {
                    SignInWithEmailView(showEmailSigningPage: $showEmailSigningPage, isUserSignedIn: $isUserSignedIn)
                        .zIndex(1)
                } else {
                    SignUpWithEmailView(showEmailSigningPage: $showEmailSigningPage, isUserSignedIn: $isUserSignedIn)
                        .zIndex(1)
                }
            }
        }
        .onChange(of: isUserSignedIn) { _, newValue in
            if newValue {
                withAnimation(.easeInOut(duration: 0.25)) {
                    reset(for: .dismiss)
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Helpers
extension BeatitudoMediaSigningView {
    private enum ResetReason {
        case dismiss
    }
    
    private func reset(for reason: ResetReason) {
        switch reason {
        case .dismiss:
            showEmailSigningPage = false
            showSigningSheet = false
            isSigningIn = false
        }
    }
}
