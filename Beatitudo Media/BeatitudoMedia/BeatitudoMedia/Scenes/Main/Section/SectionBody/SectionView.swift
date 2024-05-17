//
//  SectionTabView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 4/30/24.
//

import SwiftUI

struct SectionView: View {    
    @EnvironmentObject var viewModel: BeatitudoMediaViewModel
    
    @Binding var currentSection       : Int
    @Binding var presentingDestination: Bool
    @Binding var destinationURL       : String
    @Binding var presentingReportSheet: Bool
    
    init(currentSection: Binding<Int>, presentingDestination: Binding<Bool>, destinationURL: Binding<String>, presentingReportSheet: Binding<Bool>) {
        self._currentSection = currentSection
        self._presentingDestination = presentingDestination
        self._destinationURL = destinationURL
        self._presentingReportSheet = presentingReportSheet
    }
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            TabView(selection: $currentSection) {
                ForEach(viewModel.sections, id: \.self) { section in
                    List {
                        ForEach(section.articles, id: \.self) { article in
                            VStack(spacing: 15) {
                                ArticleView(article: article, presentingDestination: $presentingDestination, destinationURL: $destinationURL, presentingReportSheet: $presentingReportSheet)
                                
                                Divider()
                                    .frame(height: 0.5)
                                    .background(Color.adaptiveView)
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(.inset)
                    .tag(viewModel.getSectionIndex(of: section))
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .sensoryFeedback(.selection, trigger: currentSection)
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
