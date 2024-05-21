//
//  BeatitudoMediaLogInView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import SwiftUI

struct BeatitudoMediaLogInView: View {
    @Binding var showLogInPage: Bool
    
    @State var s = false
    @State var isSigningIn = false
    
    var loginMethods = ["Google", "Naver", "Email"]
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(showLogInPage ? 0.4 : 0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showLogInPage = false
                    }
                }
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.adaptiveBackground)
                
                VStack {
                    Text("Beatitudo Media에 가입하고, 소통하세요.")
                        .padding(.top, 25)
                        .padding(.bottom, 25)
                    
                    ForEach(loginMethods, id: \.self) { method in
                        LogInMethodButton(method: method, showEmailSigningSheet: $s, isSigningIn: $isSigningIn)
                    }
                    
                    HStack {
                        Text(isSigningIn ? "Beatitudo Meida 계정이 없으신가요?" : "이미 Beatitudo Media 계정이 있으신가요?")
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
            .frame(height: 320)
            .offset(y: showLogInPage ? 0 : 350)
        }
        .sheet(isPresented: $s, content: {
            if isSigningIn {
                SignInWithEmailView()
            } else {
                SignUpWithEmailView()
            }
        })
        .ignoresSafeArea()
    }
}

#Preview {
    Test()
}
