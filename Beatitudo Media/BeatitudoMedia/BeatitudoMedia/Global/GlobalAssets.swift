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
    @AppStorage("email-link") static var emailLink: String?
}
