//
//  BeatitudoMediaLogInView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import SwiftUI

struct BeatitudoMediaLogInView: View {
    @Binding var showLogInSheet: Bool
    @Binding var isUserLoggedIn: Bool
    
    @State var showEmailsigningPage = false
    @State var isSigningIn = false
    
    var loginMethods = ["Google", "NAVER", "Email"]
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(showLogInSheet ? 0.4 : 0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showLogInSheet = false
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
                        LogInMethodButton(method: method, isUserLoggedIn: $isUserLoggedIn, showEmailSigningSheet: $showEmailsigningPage, isSigningIn: $isSigningIn, showLogInSheet: $showLogInSheet)
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
            .offset(y: showLogInSheet ? 0 : 350)
        }
        .sheet(isPresented: $showEmailsigningPage, content: {
            if isSigningIn {
                SignInWithEmailView()
            } else {
                SignUpWithEmailView()
            }
        })
        .ignoresSafeArea()
    }
}
