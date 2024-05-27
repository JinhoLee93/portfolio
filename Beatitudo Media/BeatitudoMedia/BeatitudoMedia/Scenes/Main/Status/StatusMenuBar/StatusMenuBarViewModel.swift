//
//  StatusMenuBarViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/27/24.
//

import Foundation

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
