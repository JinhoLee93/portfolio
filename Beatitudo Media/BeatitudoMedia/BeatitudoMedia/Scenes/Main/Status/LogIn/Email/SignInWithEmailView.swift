//
//  SignInWithEmailView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import SwiftUI

struct SignInWithEmailView: View {
    @StateObject private var viewModel = EmailSigningViewModel()
    
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
                VStack(alignment: .leading) {
                    Text("안녕하세요.")
                        .font(.system(size: 30))
                        .bold()
                        .padding(.top, 25)
                    
                    Text("쉼 터 Beatitudo Media에 다시 방문하신 것을 환영합니다.")
                        .padding(.bottom, 25)
                    
                    TextField(resettingPassword ? "비밀번호를 찾으실 이메일 주소를 입력해주세요." : "이메일 주소를 입력해주세요.", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .clipShape( RoundedRectangle(cornerRadius: 10) )
                        .focused($keyboardOut)
                        .frame(height: 55)
                }
                .offset(y: resettingPassword ? 63 : 0)
                
                SecureField("비밀번호를 입력해주세요.", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape( RoundedRectangle(cornerRadius: 10) )
                    .focused($keyboardOut)
                    .opacity(resettingPassword ? 0 : 1)
                    .frame(height: 55)
                
                Button {
                    if !resettingPassword {
                        viewModel.signUp()
                    } else {
                        viewModel.findPassword(email: viewModel.email)
                    }
                    keyboardOut = false
                } label: {
                    Text(resettingPassword ? "비밀번호 찾기" : "로그인하기")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape( RoundedRectangle(cornerRadius: 10) )
                }
                .disabled(viewModel.email.isEmpty && viewModel.password.isEmpty && viewModel.nickname.isEmpty)
                
                HStack {
                    Text(resettingPassword ? "Beatitudo Media에 가입되어 있으신가요?" : "비밀번호를 잊어버리셨나요?")
                        .font(.system(size: 14))
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            resettingPassword.toggle()
                        }
                        keyboardOut = false
                    } label: {
                        Text(resettingPassword ? "로그인하기" : "비밀번호 재설정하기")
                            .font(.system(size: 14))
                    }
                }
                .padding(EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0))
                
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

#Preview {
    SignInWithEmailView()
}
