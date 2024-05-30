//
//  UserProfileView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/29/24.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject var viewModel = UserProfileViewModel()
    
    @Binding var showUserProfileView: Bool
    
    @FocusState private var keyboardOut: Bool
    
    @State private var nicknameChangeSuccessful: Bool = false
    @State private var showNicknameChangeStatus: Bool = false
    @State private var showProgressView: Bool         = false
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
                .onTapGesture {
                    keyboardOut = false
                }
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 50)
                
                HStack {
                    ZStack {
                        HStack {
                            Button {
                                Task {
                                    if keyboardOut {
                                        withAnimation(.easeInOut(duration: 0.25)) {
                                            keyboardOut = false
                                        }
                                        
                                        try await Task.sleep(for: .seconds(0.4))
                                    }
                                    
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        showUserProfileView = false
                                        showNicknameChangeStatus = false
                                    }
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.adaptiveView)
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                        }
                        
                        Text("프로필")
                            .foregroundStyle(.adaptiveText)
                    }
                }
                .frame(height: 48)
                
                Spacer()
            }
            
            VStack(spacing: 20) {
                VStack {
                    HStack {
                        Text("이메일")
                            .foregroundStyle(.adaptiveText)
                        
                        Spacer()
                    }
                    
                    TextField("viewModel.email", text: $viewModel.email, prompt: Text(verbatim: "\(viewModel.email)").foregroundStyle(.gray))
                        .padding()
                        .disabled(true)
                        .background(Color.gray.opacity(0.4))
                        .clipShapeAndStrokeBorderWithRoundedRectangle(cornerRadius: 25, borderColor: .clear)
                        .textInputAutocapitalization(.never)
                        .frame(height: 55)
                }
                
                VStack {
                    HStack {
                        Text("닉네임")
                            .foregroundStyle(.adaptiveText)
                        
                        Text(nicknameChangeSuccessful ? "변경 성공!" : "변경에 실패했어요. 나중에 다시 시도해 주세요.")
                            .foregroundStyle(nicknameChangeSuccessful ? .blue : .red)
                            .opacity(showNicknameChangeStatus ? 1 : 0)
                        
                        Spacer()
                    }
                    
                    TextField(viewModel.nicknamePlaceholder, text: $viewModel.nickname)
                        .focused($keyboardOut)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .clipShapeAndStrokeBorderWithRoundedRectangle(cornerRadius: 25, borderColor: viewModel.isValidNickname ? .clear : .red)
                        .textInputAutocapitalization(.never)
                        .frame(height: 55)
                        .onTapGesture {
                            showNicknameChangeStatus = false
                        }
                    
                    HStack {
                        Text("바꾸실 닉네임은 2자 이상으로 입력해주세요.")
                            .foregroundStyle(.red)
                            .opacity(viewModel.isValidNickname ? 0 : 1)
                        
                        Spacer()
                    }
                }
                
                Button {
                    Task {
                        do {
                            showProgressView = true
                            try await viewModel.changeUserNickname(newNickname: viewModel.nickname)
                            nicknameChangeSuccessful = true
                            showNicknameChangeStatus = true
                            showProgressView = false
                            keyboardOut = false
                        } catch {
                            print("\(error) occurred updating the user's nickname.")
                            nicknameChangeSuccessful = false
                            showNicknameChangeStatus = true
                            showProgressView = false
                            keyboardOut = false
                        }
                    }
                } label: {
                    Text("닉네임 변경하기")
                        .font(.headline)
                        .foregroundStyle((!viewModel.isValidNickname || (viewModel.nickname == viewModel.nicknamePlaceholder)) ? .gray.opacity(0.5) : .adaptiveBackground)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.adaptiveView)
                        .clipShapeAndStrokeBorderWithRoundedRectangle(cornerRadius: 25, borderColor: .clear)
                        .font(.system(size: 12))
                }
                .overlay( 
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(.adaptiveView)
                        .overlay(ProgressView())
                        .opacity(showProgressView ? 1 : 0)
                )
                .disabled(!viewModel.isValidNickname || (viewModel.nickname == viewModel.nicknamePlaceholder))
            }
            .animation(.easeInOut(duration: 0.25), value: keyboardOut)
            .offset(y: keyboardOut ? -200 : 0)
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .ignoresSafeArea()
    }
}
