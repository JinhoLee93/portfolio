//
//  FortySecondsApp.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/12/22.
//

import SwiftUI

@main
struct FortySecondsApp: App {
    let game = FortySecondsGame()
    
    var body: some Scene {
        WindowGroup {
            FortySecondsView(game: game)
        }
    }
}
