//
//  Page.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 4/30/24.
//

import SwiftUI

struct Section: Identifiable {
    let id = UUID()
    let title: String
    let articles: [Article]
}
