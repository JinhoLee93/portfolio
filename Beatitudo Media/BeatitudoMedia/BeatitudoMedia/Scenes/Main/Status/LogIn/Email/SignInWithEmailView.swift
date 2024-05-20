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
    @Published var nickname = ""
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty, !nickname.isEmpty else {
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
    
    func findPassword(email: String) {
        
        return
    }
}

struct SignInWithEmailView: View {
    @StateObject private var viewModel = SignInWithEmailViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var keyboardOut: Bool
    
    @State private var keyboardOffsetY: CGFloat  = 200
    @State private var resettingPassword: Bool   = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.adaptiveBackground
                .onTapGesture {
                    keyboardOut = false
                }
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.adaptiveView)
            }
            .padding(.leading, 15)
            .padding(.top, 15)
            
            VStack {
                VStack {
                    Text("안녕하세요, \n쉼 터 Beatitudo Media에 오신 것을 환영합니다.")
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0))
                    
                    TextField(resettingPassword ? "비밀번호를 찾으실 이메일 주소를 입력해주세요." : "사용하실 이메일 주소를 입력해주세요.", text: $viewModel.email)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .clipShape( RoundedRectangle(cornerRadius: 10) )
                        .focused($keyboardOut)
                        .frame(height: 55)
                }
                .offset(y: resettingPassword ? 60 : 0)
                
                SecureField("사용하실 비밀번호를 입력해주세요.", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape( RoundedRectangle(cornerRadius: 10) )
                    .focused($keyboardOut)
                    .opacity(resettingPassword ? 0 : 1)
                    .frame(height: 55)
                
                TextField("사용하실 닉네임을 입력해주세요.", text: $viewModel.nickname)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape( RoundedRectangle(cornerRadius: 10) )
                    .focused($keyboardOut)
                    .opacity(resettingPassword ? 0 : 1)
                    .frame(height: 55)
                
                Button {
                    if !resettingPassword {
                        viewModel.signIn()
                    } else {
                        viewModel.findPassword(email: "")
                    }
                    keyboardOut = false
                } label: {
                    Text(resettingPassword ? "비밀번호 찾기" : "로그인")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape( RoundedRectangle(cornerRadius: 10) )
                }
                .disabled(viewModel.email.isEmpty && viewModel.password.isEmpty && viewModel.nickname.isEmpty)
                .offset(y: resettingPassword ? -60 : 0)
                
                HStack {
                    Text("비밀번호를 잊어버리셨나요?")
                        .font(.system(size: 14))
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            resettingPassword.toggle()
                        }
                        keyboardOut = false
                    } label: {
                        Text("비밀번호 재설정하기")
                            .font(.system(size: 14))
                    }
                }
                .padding(EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0))
                .offset(y: resettingPassword ? -60 : 0)
                
                Spacer()
            }
            .padding()
            .offset(y: keyboardOffsetY)
        }
        .onChange(of: keyboardOut) { _, _ in
            withAnimation(.easeInOut(duration: 0.25)) {
                keyboardOffsetY = keyboardOut ? 0 : 200
            }
        }
        .ignoresSafeArea()
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
