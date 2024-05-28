//
//  GlobalAssets.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import SwiftUI

class GlobalAssets {
    @AppStorage("isLightMode") static var isLightMode: Bool       = true
    @AppStorage("isUserSignedIn") static var isUserSignedIn: Bool = false
    @AppStorage("serverIP") static var serverIP                   = "172.30.1.54:8000"
    @AppStorage("currentUserID") static var currentUserID: Int?
    @AppStorage("currentUserEmail") static var currentUserEmail: String?
    @AppStorage("currentUserNickname") static var currentUserNickname: String?
    
    static var currentUser: BeatitudoMediaUser? = nil
}

// MARK: - Reset Related
extension GlobalAssets {
    static func signOutCurrentUser() {
        currentUserID = nil
        currentUserEmail = nil
        currentUserNickname = nil
        currentUser = nil
        isUserSignedIn = false
        print("signing out")
    }
    
    static func signUpOrInUser(user: BeatitudoMediaUser?, id: Int?, email: String?, nickname: String?) {
        guard let id = id, let email = email, let nickname = nickname else { return }
        currentUserID = id
        currentUserEmail = email
        currentUserNickname = nickname
        currentUser = user
        isUserSignedIn = true
        print("signing in with user \(currentUser)")
    }
}
