//
//  BeatitudoMediaView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI

struct BeatitudoMediaView: View {
    @State var sections: [Section] = [
        Section(sectionTitle: "Beatitudo Media", color: .yellow),
        Section(sectionTitle: "World", color: .green),
        Section(sectionTitle: "Politics", color: .red),
        Section(sectionTitle: "You", color: .blue),
        Section(sectionTitle: "Crew", color: .cyan),
        Section(sectionTitle: "The Weeknd", color: .orange),
        Section(sectionTitle: "Drake", color: .indigo)
    ]
    
    @State var currentSection: Int = 0
    
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                SectionBar(sections: $sections, currentSectionIndex: $currentSection)
                Divider()
                SectionView(sections: $sections, currentSection: $currentSection)
            }
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
