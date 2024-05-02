//
//  SectionBae.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI

struct SectionBar: View {    
    @Binding var sections: [Section]
    @Binding var currentSectionIndex: Int
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(spacing: 20) {
                        ForEach(sections) { section in
                            VStack(spacing: 5) {
                                Spacer()
                                Text(section.sectionTitle)
                                    .foregroundStyle(currentSectionIndex == getSectionIndex(of: section) ? .adaptiveText : .gray)
                                
                                Color.clear
                                    .background(currentSectionIndex == getSectionIndex(of: section) ? .adaptiveText : .clear)
                                    .frame(height: 2)
                            }
                            .id(section.sectionTitle)
                            .onTapGesture {
                                currentSectionIndex = getSectionIndex(of: section)
                            }
                            .onChange(of: currentSectionIndex) { _, _ in
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    proxy.scrollTo(sections[currentSectionIndex].sectionTitle, anchor: .center)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .frame(height: 44)
    }
    
    private func getSectionIndex(of section: Section) -> Int {
        
        return sections.firstIndex { $0.id == section.id } ?? 0
    }
}

#Preview {
    BeatitudoMediaView()
}
