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
    @State var currentIndex: Int = 0
    @State var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex, content:  {
                ForEach(sections) { section in
                    ZStack {
                        ScrollView {
                            VStack {
                                section.color
                                Text(section.sectionTitle)
                            }
                        }
                    }
                    .overlay(
                        GeometryReader { proxy in
                            Color.clear
                                .preference(key: OffsetKey.self, value: proxy.frame(in: .global).minX)
                        }
                    )
                    .onPreferenceChange(OffsetKey.self, perform: { offset in
                        self.offset = offset
                    })
                    .tag(getIndex(section: section))
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .onChange(of: offset) { _ in
            if currentIndex == 0 && offset == 0 {
                currentIndex = sections.count - 2
            } else if currentIndex == sections.count - 1 && offset == 0 {
                currentIndex = 1
            }
        }
        .onAppear {
            guard var first = sections.first else {
                
                return
            }
            
            guard var last = sections.last else {
                
                return
            }
            
            first.id = UUID().uuidString
            last.id = UUID().uuidString
            
            sections.append(first)
            sections.insert(last, at: 0)
             
            currentIndex = 1
        }
    }
    
    func getIndex(section: Section) -> Int {
    
        return sections.firstIndex { currentSection in return currentSection.id == section.id} ?? 0
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    ContentView()
}
