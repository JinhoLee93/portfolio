//
//  LogInMethodButton.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import SwiftUI

struct LogInMethodButton: View {
    let method: String
    
    @Binding var s: Bool
    @Binding var isSigningIn: Bool
    
    var body: some View {
        Button {
            s = true
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
