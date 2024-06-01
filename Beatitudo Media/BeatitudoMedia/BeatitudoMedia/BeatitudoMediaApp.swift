//
//  BeatitudoMediaApp.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 4/30/24.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct BeatitudoMediaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var isLightModeOn = GlobalAssets.isLightModeOn
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BeatitudoMediaView(isLightModeOn: $isLightModeOn)
                    .preferredColorScheme(isLightModeOn ? .light : .dark)
            }
        }
    }
}
