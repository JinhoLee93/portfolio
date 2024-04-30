//
//  Page.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 4/30/24.
//

import SwiftUI

struct Section: Identifiable, Hashable {
    var id: UUID = .init()
    var sectionTitle: String
    var color: Color
}
