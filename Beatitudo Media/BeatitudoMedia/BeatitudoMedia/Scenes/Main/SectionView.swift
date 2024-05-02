//
//  MainView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 4/30/24.
//

import SwiftUI

struct SectionView: View {    
    @Binding var sections: [Section]
    @Binding var currentSection: Int
    
    var body: some View {
        ZStack {
            TabView(selection: $currentSection) {
                ForEach(sections) { section in
                    ZStack {
                        List {
                            VStack {
                                Text(section.sectionTitle)
                                Text(section.sectionTitle)
                                Text(section.sectionTitle)
                            }
                        }
                        .listStyle(.inset)
                    }
                    .tag(getSectionIndex(of: section))
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    private func getSectionIndex(of section: Section) -> Int {
        
        return sections.firstIndex { $0.sectionTitle == section.sectionTitle } ?? 0
    }
}

#Preview {
    BeatitudoMediaView()
}
