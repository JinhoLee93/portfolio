//
//  SectionTabView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 4/30/24.
//

import SwiftUI

struct SectionView: View {    
    @Binding var sections: [Section]
    @Binding var currentSection: Int
    @Binding var presentingDestination: Bool
    @Binding var destinationURL: String
    
    var body: some View {
        ZStack {
            TabView(selection: $currentSection) {
                ForEach(sections) { section in
                    List {
                        ForEach(section.articles, id: \.self) { article in
                            VStack(spacing: 0) {
                                ArticleView(article: article, presentingDestination: $presentingDestination, destinationURL: $destinationURL)
                                    .padding(.bottom, 20)
                                
                                Divider()
                                    .background(.adaptiveView)
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(.inset)
                    .tag(getSectionIndex(of: section))
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
    
    private func getSectionIndex(of section: Section) -> Int {
        
        return sections.firstIndex { $0.title == section.title } ?? 0
    }
}

#Preview {
    BeatitudoMediaView()
}
