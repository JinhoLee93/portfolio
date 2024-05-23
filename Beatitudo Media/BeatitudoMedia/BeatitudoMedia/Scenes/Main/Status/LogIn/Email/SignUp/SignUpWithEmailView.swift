//
//  BeatitudoMediaLogInView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/18/24.
//

import SwiftUI

struct SignUpWithEmailView: View {
    @StateObject private var viewModel = EmailSigningViewModel()
        
    @FocusState private var keyboardOut: FocusField?
    
    @Binding var showEmailSigningPage: Bool
    @Binding var isUserLoggedIn: Bool
    
    @State private var keyboardOffsetY: CGFloat = 0
    @State private var showProgressView: Bool   = false
    @State private var showPassword: Bool       = false
    
    var body: some View {
        if showEmailSigningPage {
            NavigationStack {
                ZStack {
                    BeatitudoMediaProgressView()
                        .opacity(showProgressView ? 1 : 0)
                        .zIndex(1)
                    
                    Color.adaptiveBackground
                        .onTapGesture {
                            keyboardOut = nil
                        }
                    
                    VStack {
                        Spacer()
                            .frame(height: 45)
                        
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    showEmailSigningPage = false
                                    keyboardOut = nil
                                    keyboardOffsetY = 0
                                    viewModel.reset()
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
                                .padding()
                                .background(Color.gray.opacity(0.4))
                                .clipShapeAndStrokeBorderWithRoundedRectangle(cornerRadius: 25, borderColor: viewModel.isValidEmail ? .clear : .red)
                                .focused($keyboardOut, equals: .email)
                                .textInputAutocapitalization(.never)
                                .frame(height: 55)
                            
                            Text("올바른 이메일 주소를 입력해주세요.")
                                .opacity(viewModel.isValidEmail ? 0 : 1)
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
                                
                                TextField("사용하실 비밀번호를 입력해주세요.", text: $viewModel.password)
                                    .padding()
                                    .focused($keyboardOut, equals: .passwordShown)
                                    .textInputAutocapitalization(.never)
                                    .opacity(showPassword ? 1 : 0)
                                
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
                            
                            Text("닉네임은 1자 이상으로 입력해주세요.")
                                .opacity(viewModel.isValidNickname ? 0 : 1)
                                .font(.system(size: 12))
                                .foregroundStyle(.red)
                                .padding(.leading, 5)
                        }
                        
                        Button {
                            keyboardOut = nil
                            Task {
                                do {
                                    showProgressView = true
                                    try await viewModel.signUp()
                                    isUserLoggedIn = GlobalAssets.isUserLoggedIn
                                    showProgressView = false
                                } catch {
                                    showProgressView = false
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
            .onChange(of: isUserLoggedIn) { _, newValue in
                if newValue == true {
                    showEmailSigningPage = false
                    keyboardOut = nil
                }
            }
            .transition(.move(edge: .bottom))
        }
    }
}

enum FocusField: Hashable {
    case email
    case passwordHidden
    case passwordShown
    case nickname
}

extension View {
    func clipShapeAndStrokeBorderWithRoundedRectangle(cornerRadius: CGFloat, borderColor: Color) -> some View {
        let roundedRectangle = RoundedRectangle(cornerRadius: cornerRadius)
        
        return clipShape(roundedRectangle).overlay(roundedRectangle.strokeBorder(borderColor))
    }
}
