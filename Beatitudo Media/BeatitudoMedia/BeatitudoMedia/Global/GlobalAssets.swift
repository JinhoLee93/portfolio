//
//  GlobalAssets.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import SwiftUI

class GlobalAssets {
    @AppStorage("isLightMode") static var isLightMode: Bool = true
    @AppStorage("isUserLoggedIn") static var isUserLoggedIn: Bool = false
    @AppStorage("currentUserID") static var currentUserUUID: String?
    @AppStorage("serverIP") static var serverIP = "127.0.0.1:8000"
}
