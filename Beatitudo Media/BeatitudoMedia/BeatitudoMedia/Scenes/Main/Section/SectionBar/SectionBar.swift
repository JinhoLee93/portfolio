//
//  SectionBae.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI

struct SectionBar: View {
    let namespace: Namespace.ID
    
    @StateObject var viewModel: SectionBarViewModel
    
    @Binding var currentSectionIndex: Int
    
    init(sections: [Section], currentSectionIndex: Binding<Int>, namespace: Namespace.ID) {
        self._viewModel = StateObject(wrappedValue: SectionBarViewModel(sections: sections))
        self._currentSectionIndex = currentSectionIndex
        self.namespace = namespace
    }
    
    
    var body: some View {
        ZStack {
//            ScrollView(.horizontal, showsIndicators: false) {
//                ScrollViewReader { proxy in
                    HStack(spacing: 0) {
                        ForEach(viewModel.sections, id: \.self) { section in
                            VStack(spacing: 5) {
                                Spacer()
                                
                                Text(section.title)
                                    .foregroundStyle(currentSectionIndex == viewModel.getSectionIndex(of: section) ? .adaptiveText : .gray)
                                
                                if currentSectionIndex == viewModel.getSectionIndex(of: section) {
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
                                currentSectionIndex = viewModel.getSectionIndex(of: section)
                            }
//                            .onChange(of: currentSectionIndex) { _, _ in
//                                withAnimation(.easeInOut(duration: 0.15)) {
//                                    proxy.scrollTo(viewModel.sections[currentSectionIndex].title, anchor: .center)
//                                }
//                            }
                            .animation(.easeInOut(duration: 0.15), value: currentSectionIndex)
                           
                        }
                    }
//                }
//            }
//            .scrollDisabled(true)
        }
        .frame(height: 40)
    }
}

#Preview {
    BeatitudoMediaView()
}
