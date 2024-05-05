//
//  BeatitudoMediaView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI

struct BeatitudoMediaView: View {
    @State var sections: [Section] = 
    [ 
        Section(title: "정치", articles: [Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleURL: "https://www.microsoft.com/ko-kr/", articleMetadataURL: "", articleAuxiliaryDataURL: ""), Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleURL: "https://www.apple.com/", articleMetadataURL: "", articleAuxiliaryDataURL: "")]),
        Section(title: "세계", articles: [Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleURL: "https://www.meta.com/kr/en/", articleMetadataURL: "", articleAuxiliaryDataURL: ""), Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleURL: "https://sell.amazon.co.kr/", articleMetadataURL: "", articleAuxiliaryDataURL: "")]),
        Section(title: "과학/기술", articles: [Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleURL: "https://www.netflix.com/", articleMetadataURL: "", articleAuxiliaryDataURL: ""), Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleURL: "https://www.google.com/", articleMetadataURL: "", articleAuxiliaryDataURL: "")])
    ]
    @State var currentSection: Int = 0
    
    @State private var presentingDestination: Bool = false
    @State private var destinationURL: String = ""
    
    @Namespace var namespace
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.adaptiveBackground
                
                VStack(spacing: 0) {
                    SectionBar(sections: $sections, currentSectionIndex: $currentSection, namespace: namespace.self)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    
                    Divider()
                        .background(.adaptiveView)
                    
                    SectionView(sections: $sections, 
                                currentSection: $currentSection,
                                presentingDestination: $presentingDestination,
                                destinationURL: $destinationURL)
                        .ignoresSafeArea()
                }
            }
            .navigationDestination(isPresented: $presentingDestination, destination: {
                NavigationStack {
                    WebView(url: destinationURL)
                }
                .navigationTitle(Text(tokenizeURLandReturnName(destinationURL)))
                .navigationBarTitleDisplayMode(.inline)
            })
        }
    }
    
    private func tokenizeURLandReturnName(_ string: String) -> String {
        let tokens = string.split(separator: ".").map { String($0) }
        
        return tokens.count < 1 ? "" : tokens[1]
    }
}

#Preview {
    BeatitudoMediaView()
}
