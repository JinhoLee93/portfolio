//
//  WordsADayApp.swift
//  WordsADay
//
//  Created by Jinho Lee on 2/28/22.
//

import SwiftUI

@main
struct WordsADayApp: App {
    @StateObject var WordsADay = CoreDataVM()
    var body: some Scene {
        WindowGroup {
            WordsADayView(model: WordsADay)
        }
    }
}
