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
                        
                        Article(title: "\"경찰이 되고 싶어요\"‥'1형 당뇨' 율아의 도전", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/214/2024/05/06/1346818.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/214/0001346818", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        
                        Article(title: "“위탁받은 딸의 첫 카네이션, 뭉클하고도 무겁네요”[서울신문 보도 그후]", articleViews: 0, thumbnailURL: "https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202405/07/seoul/20240507183442779zvwb.jpg", articleURL: "https://v.daum.net/v/20240507183441078", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        
                        Article(title: "아버지 유품 속 5천만 원 수표 찾아준 시민…사례금도 기부", articleViews: 0, thumbnailURL: "https://img4.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202405/07/nocut/20240507170909798jiqp.jpg", articleURL: "https://v.daum.net/v/20240507170907552", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        
                        Article(title: "[단독] 가슴 잡고 순찰차 접근… 시민 살린 경찰의 눈썰미", articleViews: 0, thumbnailURL: "https://img3.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202405/07/kukminilbo/20240507161803800fkmd.jpg", articleURL: "https://v.daum.net/v/20240507161802962", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        
                        Article(title: "삼수 끝 의사된 간호사, 소장 썩은 590g 아기 살렸다", articleViews: 0, thumbnailURL: "https://news.koreadaily.com/data/photo/2024/05/07/a698eab2-60aa-40b1-9de4-9bdc653fff93.jpg", articleURL: "https://news.koreadaily.com/2024/05/06/society/generalsociety/20240506070026138.html", articleMetadataURL: "", articleAuxiliaryDataURL: "")
                        
                    ]),
            
            Section(title: "세계",
                    articles: [
                        Article(title: "아이 실수로 2000만원짜리 도자기 ‘와장창’…박물관 측 “괜찮다” 선처", articleViews: 0, thumbnailURL: "https://imgnews.pstatic.net/image/009/2024/05/05/0005298688_001_20240505195601013.jpg?type=w647", articleURL: "https://n.news.naver.com/mnews/article/009/0005298688", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        
                        Article(title: "35년전 지루한 영상이 갑자기 조회수 폭발...“덕분에 잘 잤어요” 감사인사 받는 이유", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/009/2024/05/07/5299305.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/009/0005299305", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        
                        Article(title: "진심으로 구워낸 140m…프랑스, ‘바게트 종주국’ 자존심 탈환", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/028/2024/05/06/2688210.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/028/0002688210", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        
                        Article(title: "한국계 미국인 우일연 작가, 美 최고 권위 퓰리처상 수상", articleViews: 0, thumbnailURL: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRVQEVeykWqrn754SzHKY3E4iImcojT86-qtkkEu7-kzYPz0VGgaKpJuLo0eabeuBoCfHOiE74SGKfMEeYyJTY31WSjMZpeNawIcrDIYLb50ItN9w", articleURL: "https://www.chosun.com/international/international_general/2024/05/07/J77NEWTYCFHUNNYUK2WA6UZMUE/", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        
                        Article(title: "아내 10년 보살핌에 눈 뜬 식물인간 남편… 中 네티즌 감동", articleViews: 0, thumbnailURL: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQxu5wwvULM8QIva1fxOTL8Ym9Qw4yfi8NoSOChjnxHB2VZFQ5ck0uKjVpIr82gTJ2iOexDXJt2jY5R1ckmYQH8mwe_di2IYKbr1qysR11Z-fd8ew", articleURL: "https://www.chosun.com/international/topic/2024/05/07/XBYEVYXFAZH5ZBAPMJAAELV6QI/", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                        
                        Article(title: "주인 장례식장 안 떠나는 개, 눈물만 '글썽'…\"사람보다 낫다\"", articleViews: 0, thumbnailURL: "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQWdFzX-uon_LgAaB2bgG43Ve65MGdNa_aAmUOAepJfPjbUBFqUSO4JRFZWNSO2ihyxyVAnXnXTpKnXAJDuSpYn", articleURL: "https://news.google.com/articles/CBMiQmh0dHBzOi8vc3BvcnRzLmNob3N1bi5jb20vbGlmZS8yMDI0LTA1LTA3LzIwMjQwNTA0MDEwMDAyNjU2MDAwMzk5NNIBAA?hl=ko&gl=KR&ceid=KR%3Ako", articleMetadataURL: "", articleAuxiliaryDataURL: "")
                    ]),
            
            Section(title: "과학/기술", articles: [
                Article(title: "석유 고갈 걱정 끝…만년 동안 인류 구원할 '미친 광물' 캔다", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/015/2024/05/07/4981389.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/015/0004981389", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                
                Article(title: "[애니멀리포트] 약육강식 야생에서 입양하는 앵무새…어버이의 은혜 베푼다", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/366/2024/05/07/990984.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/366/0000990984", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                
                Article(title: "“이렇게라도 한 풀렸으면…” 한국전쟁 희생자 2명, 유전자 검사로 신원 확인", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/016/2024/05/07/2305286.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/016/0002305286", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                
                Article(title: "아동 실명 부르는 유전병, 유전자 가위로 치료 첫 성공", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/366/2024/05/07/990937.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/366/0000990937", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                
                Article(title: "국내 암 사망률 1위 ‘폐암’… 진단·치료 동시에 하는 약물 개발", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/366/2024/05/07/990906.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/366/0000990906", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                
                Article(title: "파킨슨병 환자 '비대면 운동'도 효과…증상 호전·우울증 감소까지", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/421/2024/05/07/7524457.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/421/0007524457", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                
                Article(title: "KAIST ‘마법의 물방울’ 신개념 가습기", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/016/2024/05/07/2305189.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/016/0002305189", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                
                Article(title: "‘21세기 만병통치약’...비만치료제 ‘위고비’ 지방간에도 효과 있다", articleViews: 0, thumbnailURL: "https://mimgnews.pstatic.net/image/origin/023/2024/05/06/3832579.jpg?type=nf220_150", articleURL: "https://n.news.naver.com/mnews/article/023/0003832579", articleMetadataURL: "", articleAuxiliaryDataURL: ""),
                
                Article(title: "공중에서 무작정 부유하는 봄꽃을 보면 나도 모르게 '랄랄라'", articleViews: 0, thumbnailURL: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcT1Kv_bbL7kF_KH-5X5xiT377hOjtDtlylTHnnOHtIHu5gcFEp4JklwufE4KOW0KVPzSKkLllUPduIfd8kImzeZgZ6e5VWBJ7VrMgsVyamxEto35A", articleURL: "https://www.hankyung.com/article/202404242764i", articleMetadataURL: "", articleAuxiliaryDataURL: "")
            ]),
            
            Section(title: "Funny!", articles: [
                Article(title: "[출근길 인터뷰] '팔도의 말맛'…\"사투리는 못 참지\"", articleViews: 0, thumbnailURL: "https://img1.daumcdn.net/thumb/S470x268ht.u/?fname=https%3A%2F%2Ft1.daumcdn.net%2Fnews%2F202405%2F07%2Fnewsy%2F20240507083703631umtq.jpg&scode=media2", articleURL: "https://v.daum.net/v/20240507083703028", articleMetadataURL: "", articleAuxiliaryDataURL: "")
            ])
        ]
    }
    
    func tokenizeURLandReturnName(_ string: String) -> String {
        let tokens = string.split(separator: ".").map { String($0) }
        
        return tokens.count < 1 ? "" : tokens[1]
    }
}
