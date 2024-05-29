//
//  StatusMenuBar.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/26/24.
//

import SwiftUI

struct StatusMenuBar: View {
    @StateObject private var viewModel: StatusMenuBarViewModel
    
    @Binding var showStatusPage         : Bool
    @Binding var showProfilePage        : Bool
    @Binding var showViewedArticlesPage : Bool
    @Binding var showLovedArticlesPage  : Bool
    
    init(menuTitle: String, showStatusPage: Binding<Bool>, showProfilePage: Binding<Bool>, showViewedArticlesPage: Binding<Bool>, showLovedArticlesPage: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: StatusMenuBarViewModel(menuTitle: menuTitle))
        self._showProfilePage = showProfilePage
        self._showViewedArticlesPage = showViewedArticlesPage
        self._showLovedArticlesPage = showLovedArticlesPage
        self._showStatusPage = showStatusPage
    }
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                showStatusPage = false
            }
            
            if viewModel.menuTitle == "프로필" {
                showProfilePage = true
            } else if viewModel.menuTitle == "읽은 기사" {
                showViewedArticlesPage = true
            } else {
                showLovedArticlesPage = true
            }
        } label: {
            ZStack {
                Color.adaptiveBackground
                
                HStack {
                    Image(systemName: "\(viewModel.iconTitle)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 20)
                        .foregroundStyle(.adaptiveView)
                    
                    Text("\(viewModel.menuTitle)")
                        .font(.system(size: 20))
                        .foregroundStyle(.adaptiveText)
                    
                    Spacer()
                }
                .padding(.leading, 20)
            }
        }
        .transition(.move(edge: .leading))
    }
}
