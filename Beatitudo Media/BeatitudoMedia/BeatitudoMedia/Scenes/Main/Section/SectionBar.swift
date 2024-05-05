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
    
    let namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(spacing: 20) {
                        ForEach(sections) { section in
                            VStack(spacing: 5) {
                                Spacer()
                                Text(section.title)
                                    .foregroundStyle(currentSectionIndex == getSectionIndex(of: section) ? .adaptiveText : .gray)
                                
                                if currentSectionIndex == getSectionIndex(of: section) {
                                    Color.adaptiveText
                                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                                        .frame(height: 2)
                                } else {
                                    Color.clear
                                        .frame(height: 2)
                                }
                            }
                            .id(section.title)
                            .onTapGesture {
                                currentSectionIndex = getSectionIndex(of: section)
                            }
                            .onChange(of: currentSectionIndex) { _, _ in
                                withAnimation(.easeInOut(duration: 0.15)) {
                                    proxy.scrollTo(sections[currentSectionIndex].title, anchor: .center)
                                }
                            }
                            .animation(.easeInOut(duration: 0.15), value: currentSectionIndex)
                        }
                    }
                }
            }
        }
        .frame(height: 40)
    }
    
    private func getSectionIndex(of section: Section) -> Int {
        
        return sections.firstIndex { $0.id == section.id } ?? 0
    }
}

#Preview {
    BeatitudoMediaView()
}
