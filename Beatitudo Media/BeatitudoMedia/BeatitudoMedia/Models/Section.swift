//
//  Page.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 4/30/24.
//

import SwiftUI

// Only three sections - 감동, 재미, 행복
struct Section: Codable, Hashable {
    let title: String
    let articles: [Article]
}
