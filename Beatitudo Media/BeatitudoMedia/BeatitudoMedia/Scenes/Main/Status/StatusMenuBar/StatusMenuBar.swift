//
//  StatusMenuBar.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/26/24.
//

import Foundation
import SwiftUI

class StatusMenuBarViewModel: ObservableObject {
    let menuTitle: String
    let iconTitle: String
    
    init(menuTitle: String) {
        switch menuTitle {
        case "profile":
            self.menuTitle = "프로필"
            self.iconTitle = "person.circle"
        case "viewedArticles":
            self.menuTitle = "읽은 기사"
            self.iconTitle = "clock"
        case "likedArticles":
            self.menuTitle = "좋아한 기사"
            self.iconTitle = "heart.fill"
        default:
            self.menuTitle = "인지할 수 없는 메뉴"
            self.iconTitle = "questionmark.circle"
        }
    }
    
    enum MenuTitle: String {
        case profile = "profile"
        case viewedArticles = "viewedArticle"
        case likedArticles = "likedArticle"
    }
}

struct StatusMenuBar: View {
    @StateObject private var viewModel: StatusMenuBarViewModel
    
    init(menuTitle: String) {
        self._viewModel = StateObject(wrappedValue: StatusMenuBarViewModel(menuTitle: menuTitle))
    }
    
    var body: some View {
        Button {
            
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
    }
}


#Preview {
    StatusMenuBar(menuTitle: "profile")
}
