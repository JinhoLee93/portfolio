//
//  SignUpWithEmailView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/18/24.
//

import SwiftUI

struct SignUpWithEmailView: View {
    @StateObject private var viewModel = EmailSigningViewModel()
        
    @FocusState private var keyboardOut: Utils.EmailSigningFocusField?
    
    @Binding var showEmailSigningPage: Bool
    @Binding var isUserSignedIn: Bool
    
    @State private var keyboardOffsetY: CGFloat  = 0
    @State private var showPassword: Bool        = false
    @State private var didSignUpErrorOccur: Bool = false
    @State private var showProgressView: Bool    = false
        
    var body: some View {
        if showEmailSigningPage {
            NavigationStack {
                ZStack {
                    Color.adaptiveBackground
                        .onTapGesture {
                            reset(for: .tappedBackground)
                        }
                    
                    BeatitudoMediaProgressView()
                        .opacity(showProgressView ? 1 : 0)
                        .zIndex(1)
                    
                    VStack {
                        Spacer()
                            .frame(height: 45)
                        
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    reset(for: .dismiss)
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.adaptiveView)
                            }
                            
                            Spacer()
                        }
                        .frame(height: 40)
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    VStack(alignment: .leading) {
                        Text("반갑습니다.")
                            .font(.system(size: 30))
                            .bold()
                            .padding(.top, 25)
                        
                        Text("쉼 터 Beatitudo Media에 오신 것을 환영합니다.")
                            .padding(.bottom, 25)
                        
                        VStack(alignment: .leading) {
                            TextField("사용하실 이메일 주소를 입력해주세요.", text: $viewModel.email)
                                .keyboardType(.emailAddress)
                                .padding()
                                .background(Color.gray.opacity(0.4))
                                .clipShapeAndStrokeBorderWithRoundedRectangle(cornerRadius: 25, borderColor: (viewModel.isValidEmail && !didSignUpErrorOccur) ? .clear : .red)
                                .focused($keyboardOut, equals: .email)
                                .textInputAutocapitalization(.never)
                                .frame(height: 55)
                                .onTapGesture {
                                    didSignUpErrorOccur = false
                                }
                            
                            Text(didSignUpErrorOccur ? "다른 이메일 주소를 입력해주세요." : "올바른 이메일 주소를 입력해주세요.")
                                .opacity((viewModel.isValidEmail && !didSignUpErrorOccur) ? 0 : 1)
                                .font(.system(size: 12))
                                .foregroundStyle(.red)
                                .padding(.leading, 5)
                        }
                        
                        VStack(alignment: .leading) {
                            ZStack(alignment: .trailing) {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundStyle(.gray.opacity(0.4))
                                    .clipShapeAndStrokeBorderWithRoundedRectangle(cornerRadius: 25, borderColor: viewModel.isValidPassword ?  .clear : .red)
                                
                                SecureField("사용하실 비밀번호를 입력해주세요.", text: $viewModel.password)
                                    .padding()
                                    .focused($keyboardOut, equals: .passwordHidden)
                                    .textInputAutocapitalization(.never)
                                    .opacity(showPassword ? 0 : 1)
                                    .keyboardType(.alphabet)
                                
                                TextField("사용하실 비밀번호를 입력해주세요.", text: $viewModel.password)
                                    .padding()
                                    .focused($keyboardOut, equals: .passwordShown)
                                    .textInputAutocapitalization(.never)
                                    .opacity(showPassword ? 1 : 0)
                                    .keyboardType(.alphabet)
                                
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.adaptiveView)
                                    .padding(.trailing, 10)
                                    .onTapGesture {
                                        showPassword.toggle()
                                        if keyboardOut != nil {
                                            if keyboardOut == .passwordHidden {
                                                keyboardOut = .passwordShown
                                            } else {
                                                keyboardOut = .passwordHidden
                                            }
                                        }
                                    }
                            }
                            .frame(height: 55)
                            
                                
                            Text("비밀번호는 6자 이상으로 입력해주세요.")
                                .opacity(viewModel.isValidPassword ? 0 : 1)
                                .font(.system(size: 12))
                                .foregroundStyle(.red)
                                .padding(.leading, 5)
                        }
                        
                        VStack(alignment: .leading) {
                            TextField("사용하실 닉네임을 입력해주세요.", text: $viewModel.nickname)
                                .padding()
                                .background(Color.gray.opacity(0.4))
                                .clipShapeAndStrokeBorderWithRoundedRectangle(cornerRadius: 25, borderColor: viewModel.isValidNickname ? .clear : .red)
                                .focused($keyboardOut, equals: .nickname)
                                .textInputAutocapitalization(.never)
                                .frame(height: 55)
                            
                            Text("닉네임은 2자 이상으로 입력해주세요.")
                                .opacity(viewModel.isValidNickname ? 0 : 1)
                                .font(.system(size: 12))
                                .foregroundStyle(.red)
                                .padding(.leading, 5)
                        }
                        
                        Button {
                            reset(for: .submit)
                            Task {
                                do {
                                    showProgressView = true
                                    try await viewModel.signUp()
                                    showProgressView = false
                                } catch {
                                    print("\(error) occurred creating the user with \(viewModel.email)")
                                    showProgressView = false
                                    reset(for: .signUpError)
                                }
                            }
                        } label: {
                            Text("가입하기")
                                .font(.headline)
                                .foregroundStyle(.adaptiveBackground)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(.adaptiveView)
                                .clipShape( RoundedRectangle(cornerRadius: 25) )
                        }
                        .disabled((!viewModel.isValidEmail || !viewModel.isValidPassword || !viewModel.isValidNickname) ||
                                  (viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.nickname.isEmpty))
                    }
                    .padding()
                    .offset(y: keyboardOffsetY)
                }
                .onChange(of: keyboardOut) { oldValue, newValue in
                    withAnimation(.easeInOut(duration: 0.25)) {
                        keyboardOffsetY = keyboardOut != nil ? -200 : 0
                    }
                }
            }
            .onChange(of: viewModel.user) { _, newValue in
                if newValue != nil {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        reset(for: .signUp)
                    }
                }
            }
            .transition(.move(edge: .bottom))
        }
    }
}

// MARK: - Helpers
extension SignUpWithEmailView {
    private enum ResetReason {
        case tappedBackground
        case dismiss
        case signUp
        case submit
        case signUpError
    }
    
    private func reset(for reason: ResetReason) {
        switch reason {
        case .tappedBackground:
            keyboardOut = nil
        case .dismiss:
            showEmailSigningPage = false
            didSignUpErrorOccur = false
            keyboardOut = nil
            keyboardOffsetY = 0
            viewModel.reset()
        case .signUp:
            isUserSignedIn = true
            showEmailSigningPage = false
            keyboardOut = nil
        case .submit:
            keyboardOut = nil
        case .signUpError:
            didSignUpErrorOccur = true
            viewModel.resetEmail()
        }
    }
}
