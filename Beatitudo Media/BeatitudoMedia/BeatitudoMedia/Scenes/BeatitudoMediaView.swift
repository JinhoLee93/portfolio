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
        Section(title: "정치", articles: [Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleMetadataURL: "", articleAuxiliaryDataURL: ""), Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleMetadataURL: "", articleAuxiliaryDataURL: "")]),
        Section(title: "세계", articles: [Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleMetadataURL: "", articleAuxiliaryDataURL: ""), Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleMetadataURL: "", articleAuxiliaryDataURL: "")]),
        Section(title: "과학/기술", articles: [Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleMetadataURL: "", articleAuxiliaryDataURL: ""), Article(title: "asdasd", thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleMetadataURL: "", articleAuxiliaryDataURL: "")])
    ]
    
    @State var currentSection: Int = 0
    
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                SectionBar(sections: $sections, currentSectionIndex: $currentSection, namespace: namespace.self)
                
                Divider()
                    .background(Color.adaptiveText)
                
                SectionView(sections: $sections, currentSection: $currentSection)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
