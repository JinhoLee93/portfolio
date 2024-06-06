//
//  GlobalAssets.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import SwiftUI

class GlobalAssets {
    @AppStorage("isLightModeOn") static var isLightModeOn: Bool   = true
    @AppStorage("isUserSignedIn") static var isUserSignedIn: Bool = false
    @AppStorage("serverIp") static var serverIp                   = "172.30.1.35:8000"
    @AppStorage("currentUserID") static var currentUserId: Int?
    @AppStorage("currentUserEmail") static var currentUserEmail: String?
    @AppStorage("currentUserNickname") static var currentUserNickname: String?
    
    static var currentUser: BeatitudoMediaUser? = nil
    
    static let maxWidth = UIScreen.main.bounds.width
}

// MARK: - Reset Related
extension GlobalAssets {
    static func signOutCurrentUser() {
        currentUserId = nil
        currentUserEmail = nil
        currentUserNickname = nil
        currentUser = nil
        isUserSignedIn = false
        print("signing out")
    }
    
    static func signUpOrInUser(user: BeatitudoMediaUser?, id: Int?, email: String?, nickname: String?) {
        guard let id = id, let email = email, let nickname = nickname else { return }
        currentUserId = id
        currentUserEmail = email
        currentUserNickname = nickname
        currentUser = user
        isUserSignedIn = true
        print("signing in with user \(currentUser)")
    }
}
