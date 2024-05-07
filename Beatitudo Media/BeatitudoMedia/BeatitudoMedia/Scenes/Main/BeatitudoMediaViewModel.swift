//
//  BeatitudoMediaViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/7/24.
//

import Foundation

class BeatitudoMediaViewModel: ObservableObject {
    @Published var sections: [Section]
    
    init() {
        self.sections = [
            Section(title: "사회",
                    articles: [
                        Article(title: "32세 군인 아빠 \"벌이 대부분 식비…6남매 키우기 힘들지만 그 이상 행복\"", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/021/2024/05/05/2635702.jpg?type=ofullfill220_150", articleURL: "https://n.news.naver.com/mnews/article/021/0002635702", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        Article(title: "노래하는 장애인 딸 넘어지지 않게 무릎 꿇은 母…누리꾼 울렸다", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/031/2024/05/05/834143.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/031/0000834143", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        Article(title: "아이유는 기부 여신…어린이날 또 1억, 지금까지 총 50억", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/025/2024/05/05/3358371.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/025/0003358371", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        Article(title: "\"마음으로 낳은 두 아이 친자식처럼 키웠어요\"", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/009/2024/05/05/5298652.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/009/0005298652", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        Article(title: "새 생명 선물받은 8살 리원이…소아암 친구에게 머리카락 기부한 이유", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/029/2024/05/05/2871874.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/029/0002871874", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        Article(title: "\"다리 잃고 얻은 바퀴, 삶의 원동력 됐죠\"", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/009/2024/05/05/5298560.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/009/0005298560", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        Article(title: "\"경찰이 되고 싶어요\"‥'1형 당뇨' 율아의 도전", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/214/2024/05/06/1346818.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/214/0001346818", articleMetadataURL: "", articleAuxiliaryDataURL: "")
                        
                    ]),
            Section(title: "세계",
                    articles: [
                        Article(title: "아이 실수로 2000만원짜리 도자기 ‘와장창’…박물관 측 “괜찮다” 선처", articleViews: 0, thumbnailURL: "https://imgnews.pstatic.net/image/009/2024/05/05/0005298688_001_20240505195601013.jpg?type=w647", articleURL: "https://n.news.naver.com/mnews/article/009/0005298688", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        Article(title: "asdasd", articleViews: 0, thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleURL: "https://sell.amazon.co.kr/", articleMetadataURL: "", articleAuxiliaryDataURL: "")]),
            
            Section(title: "과학/기술", articles: [Article(title: "asdasd", articleViews: 0, thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleURL: "https://www.netflix.com/", articleMetadataURL: "", articleAuxiliaryDataURL: ""), Article(title: "asdasd", articleViews: 0, thumbnailURL: "https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg", articleURL: "https://www.google.com/", articleMetadataURL: "", articleAuxiliaryDataURL: "")])
        ]
    }
    
    func tokenizeURLandReturnName(_ string: String) -> String {
        let tokens = string.split(separator: ".").map { String($0) }
        
        return tokens.count < 1 ? "" : tokens[1]
    }
}
