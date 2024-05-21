//
//  BeatitudoMediaStatusView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/17/24.
//

import SwiftUI

struct BeatitudoMediaStatusView: View {
    @Binding var isUserLoggedIn: Bool
    @Binding var showStatusPage: Bool
    @Binding var showLogInSheet: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Color.adaptiveBackground
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showStatusPage = false
                            }
                        }
                }
                .frame(height: 40)
                
                VStack(alignment: .leading) {
                    if isUserLoggedIn {
                        Text("소중한 이진호님,")
                        Text("\(Utils.getAndClassifyCurrentHour())")
                            .frame(alignment: .trailing)
                    } else {
                        Text("로그인 후 더 많은 소통을 즐겨보세요.")
                    }
                }
                .padding(.leading, 20)
                .font(.system(size: 18))
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        if !isUserLoggedIn {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showStatusPage = false
                                
                                Task {
                                    try await Task.sleep(for: .seconds(0.25))
                                    
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        showLogInSheet = true
                                    }
                                }
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showStatusPage = false
                            }
                            try? AuthenticationManager.shared.signOut()
                            
                            Task {
                                try await Task.sleep(for: .seconds(0.25))
                                
                                isUserLoggedIn = GlobalAssets.isUserLoggedIn
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: isUserLoggedIn ? "rectangle.portrait.and.arrow.forward" : "door.left.hand.open")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(isUserLoggedIn ? "로그아웃" : "로그인")
                                .font(.system(size: 20))
                        }
                        .foregroundStyle(.adaptiveText)
                    }
                }
            }
            .frame(width: 250)
            .padding(.trailing, 20)
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
