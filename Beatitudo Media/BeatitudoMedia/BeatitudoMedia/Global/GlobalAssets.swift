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
    @AppStorage("serverIP") static var serverIP                   = "172.30.1.91:8000"
    @AppStorage("currentUserID") static var currentUserID: Int?
    @AppStorage("currentUserEmail") static var currentUserEmail: String?
    @AppStorage("currentUserNickname") static var currentUserNickname: String?
}

// MARK: - Reset Related
extension GlobalAssets {
    static func signOutCurrentUser() {
        currentUserID = nil
        currentUserEmail = nil
        currentUserNickname = nil
        isUserSignedIn = false
        print("signing out")
    }
    
    static func signUpOrInUser(id: Int?, email: String?, nickname: String?) {
        guard let id = id, let email = email, let nickname = nickname else { return }
        currentUserID = id
        currentUserEmail = email
        currentUserNickname = nickname
        isUserSignedIn = true
        print("signing in with email: \(email), nickname: \(nickname) ")
    }
}
