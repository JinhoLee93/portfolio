//
//  BeatitudoMediaLogInView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/18/24.
//

import SwiftUI

struct SignUpWithEmailView: View {
    @StateObject private var viewModel = EmailSigningViewModel()
        
    @FocusState private var keyboardOut: Bool
    
    @Binding var showEmailSigningPage: Bool
    
    @State private var keyboardOffsetY: CGFloat = 0
    @State private var verificationSent: Bool   = false
    
    var body: some View {
        if showEmailSigningPage {
            ZStack {
                Color.adaptiveBackground
                    .onTapGesture {
                        keyboardOut = false
                    }
                
                VStack {
                    Spacer()
                        .frame(height: 45)
                    
                    HStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showEmailSigningPage = false
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
                    
                    TextField("사용하실 이메일 주소를 입력해주세요.", text: $viewModel.email)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .clipShape( RoundedRectangle(cornerRadius: 10) )
                        .focused($keyboardOut)
                        .frame(height: 55)
                    
                    SecureField("사용하실 비밀번호를 입력해주세요.", text: $viewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .clipShape( RoundedRectangle(cornerRadius: 10) )
                        .focused($keyboardOut)
                        .frame(height: 55)
                    
                    TextField("사용하실 닉네임을 입력해주세요.", text: $viewModel.nickname)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .clipShape( RoundedRectangle(cornerRadius: 10) )
                        .focused($keyboardOut)
                        .frame(height: 55)
                    
                    Button {
                        viewModel.signUp()
                        keyboardOut = false
                        verificationSent = true
                    } label: {
                        Text(verificationSent ? "인증 이메일이 전송되었습니다." : "인증 이메일 전송")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape( RoundedRectangle(cornerRadius: 10) )
                    }
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.nickname.isEmpty || verificationSent)
                }
                .padding()
                .offset(y: keyboardOffsetY)
            }
            .onChange(of: keyboardOut) { _, _ in
                withAnimation(.easeInOut(duration: 0.25)) {
                    keyboardOffsetY = keyboardOut ? -200 : 0
                }
            }
            .transition(.move(edge: .bottom))
        }
    }
}

//#Preview {
//    SignUpWithEmailView()
//}
