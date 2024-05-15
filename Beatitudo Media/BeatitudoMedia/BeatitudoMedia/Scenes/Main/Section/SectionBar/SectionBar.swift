//
//  SectionBae.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI

struct SectionBar: View {
    let namespace: Namespace.ID
    
    @EnvironmentObject var viewModel: BeatitudoMediaViewModel
    
    @Binding var currentSectionIndex: Int
    
    init(currentSectionIndex: Binding<Int>, namespace: Namespace.ID) {
        self._currentSectionIndex = currentSectionIndex
        self.namespace = namespace
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                ForEach(viewModel.sections, id: \.self) { section in
                    VStack(spacing: 5) {
                        Spacer()
                        
                        Text(section.title)
                            .foregroundStyle(currentSectionIndex == viewModel.getSectionIndex(of: section) ? .adaptiveText : .gray)
                            .font(.system(size: 15))
                        
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

                    .animation(.easeInOut(duration: 0.15), value: currentSectionIndex)
                   
                }
            }
        }
        .frame(height: 40)
    }
}

#Preview {
    BeatitudoMediaView()
}
