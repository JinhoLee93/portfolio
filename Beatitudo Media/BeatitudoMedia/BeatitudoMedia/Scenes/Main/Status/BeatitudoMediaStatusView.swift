//
//  BeatitudoMediaStatusView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/17/24.
//

import SwiftUI

struct BeatitudoMediaStatusView: View {
    @Binding var isUserSignedIn: Bool
    @Binding var showStatusPage: Bool
    @Binding var showSigningSheet: Bool
    
    var menus = ["profile", "viewedArticles", "lovedArticles"]
    
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
                .padding(.trailing, 20)
                .frame(height: 40)
                
                HStack {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        if isUserSignedIn {
                            Text("소중한 \(GlobalAssets.currentUserNickname ?? "")님,")
                            Text("\(Utils.getAndClassifyCurrentHour())")
                                .frame(alignment: .trailing)
                        } else {
                            Text("로그인 후 더 많은 소통을 즐겨보세요.")
                        }
                    }
                    
                    Spacer()
                }
                .font(.system(size: 18))
                
                Spacer()
                    .frame(height: 100)
                
                if isUserSignedIn {
                    VStack(spacing: 0) {
                        ForEach(menus, id: \.self) { menu in
                            StatusMenuBar(menuTitle: menu)
                        }
                    }
                    .frame(height: 40 * CGFloat(menus.count))
                }
                
                Spacer()

                HStack {
                    Spacer()
                    
                    Button {
                        if !isUserSignedIn {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showStatusPage = false
                                
                                Task {
                                    try await Task.sleep(for: .seconds(0.25))
                                    
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        showSigningSheet = true
                                    }
                                }
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showStatusPage = false
                            }
                            Task {
                                try await Task.sleep(for: .seconds(0.25))
                                
                                do {
                                    try AuthenticationManager.shared.signOut()
                                    GlobalAssets.signOutCurrentUser()
                                    isUserSignedIn = false
                                } catch {
                                    print("\(error) occurred signing out")
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: isUserSignedIn ? "rectangle.portrait.and.arrow.forward" : "door.left.hand.open")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(isUserSignedIn ? "로그아웃" : "로그인")
                                .font(.system(size: 20))
                        }
                        .foregroundStyle(.adaptiveText)
                    }
                }
                .padding(.trailing, 20)
            }
            .frame(width: 270)
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
