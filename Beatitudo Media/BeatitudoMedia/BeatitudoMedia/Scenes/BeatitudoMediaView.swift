//
//  BeatitudoMediaView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI

struct BeatitudoMediaView: View {
    @State var sections: [Section] = [
        Section(sectionTitle: "Beatitudo Media"),
        Section(sectionTitle: "World"),
        Section(sectionTitle: "Politics"),
        Section(sectionTitle: "You"),
        Section(sectionTitle: "Crew"),
        Section(sectionTitle: "The Weeknd"),
        Section(sectionTitle: "Drake"),
        Section(sectionTitle: "d"),
        Section(sectionTitle: "c"),
        Section(sectionTitle: "k")
    ]
    
    @State var currentSection: Int = 0
    
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                SectionBar(sections: $sections, currentSectionIndex: $currentSection, namespace: namespace.self)
                Divider()
                    .background(Color.adaptiveText)
                SectionView(sections: $sections, currentSection: $currentSection)
            }
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
