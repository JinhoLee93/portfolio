from ..models import *

class Helpers:
    def load_test_data():
        Sections.objects.all().delete()
        Section.objects.all().delete()
        Article.objects.all().delete()
        Article_Metadata.objects.all().delete()
        Article_Auxiliary_Data.objects.all().delete()

        # Create the Sections wrapper for sections
        wrapper = Sections.objects.create()

        # Create Section's that go into the wrapper
        moving_section     = Section.objects.create(sections=wrapper, title='Moving') 
        happy_section      = Section.objects.create(sections=wrapper, title='Happy')
        amazing_section    = Section.objects.create(sections=wrapper, title='Amazing')
        funny_section      = Section.objects.create(sections=wrapper, title='Funny')

        # Create Article's that go into each Section
        ## For the Moving Section
        article1_moving = Article.objects.create(section=moving_section, 
                                                title='32세 군인 아빠 \"벌이 대부분 식비…6남매 키우기 힘들지만 그 이상 행복\"',
                                                thumbnail_url='https://mimgnews.pstatic.net/image/origin/021/2024/05/05/2635702.jpg?type=ofullfill220_150',
                                                article_url='https://n.news.naver.com/mnews/article/021/0002635702')
        article1_moving_metadata = Article_Metadata.objects.create(article=article1_moving, time_to_read=1, date='2024-05-07')
        article1_moving_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article1_moving)

        article2_moving = Article.objects.create(section=moving_section,
                                                title='노래하는 장애인 딸 넘어지지 않게 무릎 꿇은 母…누리꾼 울렸다',
                                                thumbnail_url='https://mimgnews.pstatic.net/image/origin/031/2024/05/05/834143.jpg?type=nf220_150',
                                                article_url='https://n.news.naver.com/mnews/article/031/0000834143')
        article2_moving_metadata = Article_Metadata.objects.create(article=article2_moving, time_to_read=1, date='2024-05-07')
        article2_moving_auxiliay_data = Article_Auxiliary_Data.objects.create(article=article2_moving)

        article3_moving = Article.objects.create(section=moving_section,
                                                title='\"마음으로 낳은 두 아이 친자식처럼 키웠어요\"',
                                                thumbnail_url='https://mimgnews.pstatic.net/image/origin/009/2024/05/05/5298652.jpg?type=nf220_150',
                                                article_url='https://n.news.naver.com/mnews/article/009/0005298652')
        article3_moving_metadata = Article_Metadata.objects.create(article=article3_moving, time_to_read=1, date='2024-05-07')
        article3_moving_auxiliay_data = Article_Auxiliary_Data.objects.create(article=article3_moving)

        article4_moving = Article.objects.create(section=moving_section,
                                                title='새 생명 선물받은 8살 리원이…소아암 친구에게 머리카락 기부한 이유',
                                                thumbnail_url='https://mimgnews.pstatic.net/image/origin/029/2024/05/05/2871874.jpg?type=nf220_150',
                                                article_url='https://n.news.naver.com/mnews/article/029/0002871874')
        article4_moving_metadata = Article_Metadata.objects.create(article=article4_moving, time_to_read=1, date='2024-05-07')
        article4_moving_auxiliay_data = Article_Auxiliary_Data.objects.create(article=article4_moving)

        article5_moving = Article.objects.create(section=moving_section,
                                                title='\"다리 잃고 얻은 바퀴, 삶의 원동력 됐죠\"',
                                                thumbnail_url='https://mimgnews.pstatic.net/image/origin/009/2024/05/05/5298560.jpg?type=nf220_150',
                                                article_url='https://n.news.naver.com/mnews/article/009/0005298560')
        article5_moving_metadata = Article_Metadata.objects.create(article=article5_moving, time_to_read=1, date='2024-05-07')
        article5_moving_auxiliay_data = Article_Auxiliary_Data.objects.create(article=article5_moving)

        article6_moving = Article.objects.create(section=moving_section,
                                                title='\"경찰이 되고 싶어요\"‥\"1형 당뇨\" 율아의 도전',
                                                thumbnail_url='https://mimgnews.pstatic.net/image/origin/214/2024/05/06/1346818.jpg?type=nf220_150',
                                                article_url='https://n.news.naver.com/mnews/article/214/0001346818')
        article6_moving_metadata = Article_Metadata.objects.create(article=article6_moving, time_to_read=1, date='2024-05-07')
        article6_moving_auxiliay_data = Article_Auxiliary_Data.objects.create(article=article6_moving)

        article7_moving = Article.objects.create(section=moving_section,
                                                title='\"위탁받은 딸의 첫 카네이션, 뭉클하고도 무겁네요\"[서울신문 보도 그후]',
                                                thumbnail_url='https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202405/07/seoul/20240507183442779zvwb.jpg',
                                                article_url='https://v.daum.net/v/20240507183441078')
        article7_moving_metadata = Article_Metadata.objects.create(article=article7_moving, time_to_read=1, date='2024-05-07')
        article7_moving_auxiliay_data = Article_Auxiliary_Data.objects.create(article=article7_moving)

        article8_moving = Article.objects.create(section=moving_section,
                                                title='삼수 끝 의사된 간호사, 소장 썩은 590g 아기 살렸다',
                                                thumbnail_url='https://news.koreadaily.com/data/photo/2024/05/07/a698eab2-60aa-40b1-9de4-9bdc653fff93.jpg',
                                                article_url='https://news.koreadaily.com/2024/05/06/society/generalsociety/20240506070026138.html')
        article8_moving_metadata = Article_Metadata.objects.create(article=article8_moving, time_to_read=1, date='2024-05-07')
        article8_moving_auxiliay_data = Article_Auxiliary_Data.objects.create(article=article8_moving)

        article9_moving = Article.objects.create(section=moving_section,
                                                title='아내 10년 보살핌에 눈 뜬 식물인간 남편… 中 네티즌 감동',
                                                thumbnail_url='https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQxu5wwvULM8QIva1fxOTL8Ym9Qw4yfi8NoSOChjnxHB2VZFQ5ck0uKjVpIr82gTJ2iOexDXJt2jY5R1ckmYQH8mwe_di2IYKbr1qysR11Z-fd8ew',
                                                article_url='https://www.chosun.com/international/topic/2024/05/07/XBYEVYXFAZH5ZBAPMJAAELV6QI/')
        article9_moving_metadata = Article_Metadata.objects.create(article=article9_moving, time_to_read=1, date='2024-05-07')
        article9_moving_auxiliay_data = Article_Auxiliary_Data.objects.create(article=article9_moving)

        article10_moving = Article.objects.create(section=moving_section,
                                                title='주인 장례식장 안 떠나는 개, 눈물만 \'글썽\'…\"사람보다 낫다\"',
                                                thumbnail_url='https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQWdFzX-uon_LgAaB2bgG43Ve65MGdNa_aAmUOAepJfPjbUBFqUSO4JRFZWNSO2ihyxyVAnXnXTpKnXAJDuSpYn',
                                                article_url='https://news.google.com/articles/CBMiQmh0dHBzOi8vc3BvcnRzLmNob3N1bi5jb20vbGlmZS8yMDI0LTA1LTA3LzIwMjQwNTA0MDEwMDAyNjU2MDAwMzk5NNIBAA?hl=ko&gl=KR&ceid=KR%3Ako')
        article10_moving_metadata = Article_Metadata.objects.create(article=article10_moving, time_to_read=1, date='2024-05-07')
        article10_moving_auxiliay_data = Article_Auxiliary_Data.objects.create(article=article10_moving)

        ## Happy Section
        article1_happy = Article.objects.create(section=happy_section,
                                                    title='아이유는 기부 여신…어린이날 또 1억, 지금까지 총 50억',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/025/2024/05/05/3358371.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/025/0003358371')
        article1_happy_metadata = Article_Metadata.objects.create(article=article1_happy, time_to_read=1, date='2024-05-07')
        article1_happy_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article1_happy)
        
        article2_happy = Article.objects.create(section=happy_section,
                                                    title='아버지 유품 속 5천만 원 수표 찾아준 시민…사례금도 기부',
                                                    thumbnail_url='https://img4.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202405/07/nocut/20240507170909798jiqp.jpg',
                                                    article_url='https://v.daum.net/v/20240507170907552')
        article2_happy_metadata = Article_Metadata.objects.create(article=article2_happy, time_to_read=1, date='2024-05-07')
        article2_happy_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article2_happy)

        article3_happy = Article.objects.create(section=happy_section,
                                                    title='[단독] 가슴 잡고 순찰차 접근… 시민 살린 경찰의 눈썰미',
                                                    thumbnail_url='https://img3.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202405/07/kukminilbo/20240507161803800fkmd.jpg',
                                                    article_url='https://v.daum.net/v/20240507161802962')
        article3_happy_metadata = Article_Metadata.objects.create(article=article3_happy, time_to_read=1, date='2024-05-07')
        article3_happy_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article3_happy)

        article4_happy = Article.objects.create(section=happy_section,
                                                    title='아이 실수로 2000만원짜리 도자기 ‘와장창’…박물관 측 “괜찮다” 선처',
                                                    thumbnail_url='https://imgnews.pstatic.net/image/009/2024/05/05/0005298688_001_20240505195601013.jpg?type=w647',
                                                    article_url='https://n.news.naver.com/mnews/article/009/0005298688')
        article4_happy_metadata = Article_Metadata.objects.create(article=article4_happy, time_to_read=1, date='2024-05-07')
        article4_happy_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article4_happy)

        article5_happy = Article.objects.create(section=happy_section,
                                                    title='공중에서 무작정 부유하는 봄꽃을 보면 나도 모르게 \'랄랄라\'',
                                                    thumbnail_url='https://imgnews.pstatic.net/image/009/2024/05/05/0005298688_001_20240505195601013.jpg?type=w647',
                                                    article_url='https://n.news.naver.com/mnews/article/009/0005298688')
        article5_happy_metadata = Article_Metadata.objects.create(article=article5_happy, time_to_read=1, date='2024-05-07')
        article5_happy_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article5_happy)

        article6_happy = Article.objects.create(section=happy_section,
                                                    title='35년전 지루한 영상이 갑자기 조회수 폭발...“덕분에 잘 잤어요” 감사인사 받는 이유',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/009/2024/05/07/5299305.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/009/0005299305')
        article6_happy_metadata = Article_Metadata.objects.create(article=article6_happy, time_to_read=1, date='2024-05-07')
        article6_happy_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article6_happy)

        article7_happy = Article.objects.create(section=happy_section,
                                                    title='35년전 지루한 영상이 갑자기 조회수 폭발...“덕분에 잘 잤어요” 감사인사 받는 이유',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/009/2024/05/07/5299305.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/009/0005299305')
        article7_happy_metadata = Article_Metadata.objects.create(article=article7_happy, time_to_read=1, date='2024-05-07')
        article7_happy_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article7_happy)

        article8_happy = Article.objects.create(section=happy_section,
                                                    title='한국계 미국인 우일연 작가, 美 최고 권위 퓰리처상 수상',
                                                    thumbnail_url='https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRVQEVeykWqrn754SzHKY3E4iImcojT86-qtkkEu7-kzYPz0VGgaKpJuLo0eabeuBoCfHOiE74SGKfMEeYyJTY31WSjMZpeNawIcrDIYLb50ItN9w',
                                                    article_url='https://www.chosun.com/international/international_general/2024/05/07/J77NEWTYCFHUNNYUK2WA6UZMUE/')
        article8_happy_metadata = Article_Metadata.objects.create(article=article8_happy, time_to_read=1, date='2024-05-07')
        article8_happy_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article8_happy)

        ## Amazing Section
        article1_amazing = Article.objects.create(section=amazing_section,
                                                    title='석유 고갈 걱정 끝…만년 동안 인류 구원할 \'미친 광물\' 캔다',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/015/2024/05/07/4981389.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/015/0004981389')
        article1_amazing_metadata = Article_Metadata.objects.create(article=article1_amazing, time_to_read=1, date='2024-05-07')
        article1_amazing_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article1_amazing)

        article2_amazing = Article.objects.create(section=happy_section,
                                                    title='[애니멀리포트] 약육강식 야생에서 입양하는 앵무새…어버이의 은혜 베푼다',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/366/2024/05/07/990984.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/366/0000990984')
        article2_amazing_metadata = Article_Metadata.objects.create(article=article2_amazing, time_to_read=1, date='2024-05-07')
        article2_amazing_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article2_amazing)

        article3_amazing = Article.objects.create(section=amazing_section,
                                                    title='\"이렇게라도 한 풀렸으면…\" 한국전쟁 희생자 2명, 유전자 검사로 신원 확인',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/016/2024/05/07/2305286.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/016/0002305286')
        article3_amazing_metadata = Article_Metadata.objects.create(article=article3_amazing, time_to_read=1, date='2024-05-07')
        article3_amazing_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article3_amazing)

        article4_amazing = Article.objects.create(section=amazing_section,
                                                    title='아동 실명 부르는 유전병, 유전자 가위로 치료 첫 성공',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/366/2024/05/07/990937.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/366/0000990937')
        article4_amazing_metadata = Article_Metadata.objects.create(article=article4_amazing, time_to_read=1, date='2024-05-07')
        article4_amazing_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article4_amazing)

        article5_amazing = Article.objects.create(section=happy_section,
                                                    title='국내 암 사망률 1위 ‘폐암’… 진단·치료 동시에 하는 약물 개발',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/366/2024/05/07/990906.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/366/0000990906')
        article5_amazing_metadata = Article_Metadata.objects.create(article=article5_amazing, time_to_read=1, date='2024-05-07')
        article5_amazing_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article5_amazing)

        article6_amazing = Article.objects.create(section=happy_section,
                                                    title='파킨슨병 환자 \'비대면 운동\'도 효과…증상 호전·우울증 감소까지',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/421/2024/05/07/7524457.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/421/0007524457')
        article6_amazing_metadata = Article_Metadata.objects.create(article=article6_amazing, time_to_read=1, date='2024-05-07')
        article6_amazing_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article6_amazing)

        article7_amazing = Article.objects.create(section=amazing_section,
                                                    title='KAIST \'마법의 물방울\' 신개념 가습기',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/016/2024/05/07/2305189.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/016/0002305189')
        article7_amazing_metadata = Article_Metadata.objects.create(article=article7_amazing, time_to_read=1, date='2024-05-07')
        article7_amazing_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article7_amazing)

        article8_amazing = Article.objects.create(section=amazing_section,
                                                    title='\'21세기 만병통치약\'...비만치료제 \'위고비\' 지방간에도 효과 있다',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/023/2024/05/06/3832579.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/023/0003832579')
        article8_amazing_metadata = Article_Metadata.objects.create(article=article8_amazing, time_to_read=1, date='2024-05-07')
        article8_amazing_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article8_amazing)

        ## Funny Section
        article1_funny = Article.objects.create(section=funny_section,
                                                    title='진심으로 구워낸 140m…프랑스, ‘바게트 종주국’ 자존심 탈환',
                                                    thumbnail_url='https://mimgnews.pstatic.net/image/origin/028/2024/05/06/2688210.jpg?type=nf220_150',
                                                    article_url='https://n.news.naver.com/mnews/article/028/0002688210')
        article1_funny_metadata = Article_Metadata.objects.create(article=article1_funny, time_to_read=1, date='2024-05-07')
        article1_funny_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article1_funny)

        article2_funny = Article.objects.create(section=funny_section,
                                                    title='[출근길 인터뷰] \'팔도의 말맛\'…\"사투리는 못 참지\"',
                                                    thumbnail_url='https://img1.daumcdn.net/thumb/S470x268ht.u/?fname=https%3A%2F%2Ft1.daumcdn.net%2Fnews%2F202405%2F07%2Fnewsy%2F20240507083703631umtq.jpg&scode=media2',
                                                    article_url='https://v.daum.net/v/20240507083703028')
        article2_funny_metadata = Article_Metadata.objects.create(article=article2_funny, time_to_read=1, date='2024-05-07')
        article2_funny_auxiliary_data = Article_Auxiliary_Data.objects.create(article=article2_funny)