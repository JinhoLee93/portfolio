//
//  MainView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 4/30/24.
//

import SwiftUI

struct MainView: View {
    @State private var sections: [Section] = [
        Section(sectionTitle: "Politics", color: Color.blue),
        Section(sectionTitle: "Technology", color: Color.gray),
        Section(sectionTitle: "World", color: Color.green),
        Section(sectionTitle: "Sports", color: Color.red),
        Section(sectionTitle: "Korea", color: Color.yellow)
    ]
    
    @State var currentSectionIndex = 0
    @State var fakeSectionIndex = 0
    
    var body: some View {
        ZStack {
            TabView(selection: self.$fakeSectionIndex) {
                ForEach(sections) { section in
                    ZStack {
                        section.color
                        Text("\(section.sectionTitle)")
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: fakeSectionIndex) { newValue in
                if newValue == 0 {
                    fakeSectionIndex = sections.count - 2
                } else if newValue == sections.count - 1 {
                    fakeSectionIndex = 1 
                }
            }
        }
    }
}

#Preview {
    MainView()
}
