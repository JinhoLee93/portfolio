# PokeDex (포켓몬 도감)

[유튜브 링크](https://youtube.com/shorts/INwuXnbQ-xA)

# 0. Tech Stack
MVVM-C & MVVM, Protocol Oriented Programming, Dependency Injection, Swift, UIKit, Rx, SnapKit, SwiftUI, Combine, Kingfisher, XCTest, RxTest, Swift Concurrency, Swift Package Manager

# 1. 개요
RESTfulAPI를 통한 [PokeAPI](https://pokeapi.co/) 오픈소스 서버를 이용해 포켓몬 정보(Official Portrait, 이름, 타입, 기술 등)를 리스트 형식으로 유저에게 보여주고, 유저는 본인 마음에 드는 포켓몬을 저장하여 라이브러리를 통해 빠르게 볼 수 있습니다.

# 2. 개발 목적
열렬한 포켓몬 딱지 콜렉터로 유년 시절을 보낸 제작자 혹은 제작자와 같은 유년기를 보낸 유저에게 향수를 불러일으켜, 잠깐이라도 어릴 때의 기분 좋은 날을 상상하며 좋은 하루를 만들 수 있기를 바라며 개발을 시작하였습니다.

# 3. Tech Stack 사용 목적

## 디자인 패턴
- **MVVM-C & MVVM**: 쉬운 디버깅과 테스트, 그리고 가독성 높은 코드를 만들면서 각 모듈(Model, View, ViewModel)마다 해야할 일이 정확히 정해진 Clean Architecture를 구현하기 위해 MVVM 디자인 패턴을 사용하였습니다.
  
## 개발 기술
- **Protocol Oriented Programming**: 하나의 Super Class를 만들고 상속을 통해 코드를 구현하기보단 그 자리에서 해당 코드에 무엇이 필요한지 정해놓고 그로부터 가지를 뻗어나가는 것이 제가 개발하는 방식과 잘 맞다고 생각되어 OOP가 아닌, 코드 레이아웃을 먼저 Protocol로서 만들어놓고 코드를 만들기 시작하였습니다.
  
- **Dependency Injection**: 코드 부분을 독립적으로 모듈화 시켜 줄어든 코드 간 의존성으로 리팩토링이 쉬워지고, 외부의 변화로부터 내부 코드를 지킬 수 있다는 장점이 있지만, 크기가 크지 않은 이 앱에선 주로 테스트를 위한 Mock Network Layer 주입을 위해 사용되었습니다.

## 프레임워크

### I. UI 관련 프레임워크

- **UIKit**: 포켓몬 정보를 사전처럼 열거해 주는 테이블 뷰는 앱의 중심이 되는 뷰입니다. 제가 구상한 비전을 최대한 구현하기 위해 SwiftUI의 List로는 구현 불가능한 섹션간 Cell 이동과 같은 Customization을 제공하고 많은 양의 셀이 한 번에 로드되었을 때 생기는 잠재적 Performance 문제를 생각하지 않아도 되는 UIKit를 선택했습니다.
  - **실제로 SwiftUI의 LazyVStack을 사용한 List는 1000개의 데이터를 넣어 테스트를 진행했을 때 26%의 CPU를 사용했고, UIKit의 UITableView는 그에 반해 오직 5%의 CPU만을 사용했습니다.**
  
- **SnapKit**: 인터페이스 빌더 사용으로 생성되는 소스코드로 인한 문제를 크게 겪었던 저는, 처음 앱을 구상할 때부터 코드로 UI를 만들겠다는 결심을 했습니다. 해당 프레임워크는 NSLayoutConstraint를 사용했을 때 생기는 코드베이스가 지저분해지는 문제를 막아주고, 쉽게 Auto Layout을 구현할 수 있도록 도와주었습니다.
  
- **SwiftUI**: 유저가 저장한 마음에 드는 포켓몬을 카드로서 보여주는 뷰를 LazyVGrid를 통해 구현하기 위해 사용하였습니다. UIKit의 Collection View를 사용했다면 최적의 CPU 사용량과 Peformance를 만들어낼 수 있었지만, SwiftUI의 AsyncImage와 같은 새롭게 추가된 기능들을 사용해 보며 연습하고 싶어 SwiftUI를 선택하였습니다.
  - **[연구결과](https://kth.diva-portal.org/smash/get/diva2:1789094/FULLTEXT01.pdf)에 따르면 SwiftUI의 LazyVGrid는 동일한 데이터를 처리하는데 UIKit의 CollectionView보다 세 배 느렸습니다.**

### II. Reactive Programming 관련 프레임워크
 
- **Rx (RxSwift, RxRelay, RxDataSource)**: UIKit를 통해 Reactive Programming과 MVVM 디자인 패턴을 구현하기 위해 꼭 필요한 Rx입니다. 총 세 개의 Rx 관련 프레임워크가 사용되었습니다.
  - **RxSwift**: Observable을 사용할 수 있게 해주는 가장 기본적인 프레임워크입니다. 앱 내부 대부분의 Reactive Programming은 Publish, Behavior Subjcet를 통해 구현되었습니다.
  - **RxRelay**: Behavior 타입의 Observable 내 데이터를 업데이트하고 싶을 때 사용되었습니다. 기존 BehaviorSubject를 사용했을 때 생기는 Nesting Subscribe 문제를 해결해 주었습니다.
  - **RxDataSource**: 완벽한 Reactive Programming을 구현하고 싶었기에 Delegate 혹은 Datasource 관련한 코드로 Controller를 채우고 싶지 않았지만, RxSwift를 통해 테이블 뷰를 Customize 하는 데엔 한계가 있었습니다. RxSwift만을 사용하면 테이블 뷰에 섹션을 나눌 수 없었고, 이 프레임워크는 그 문제를 해결해 주었습니다.
  
- **Combine**: Rx를 통해 할 수 있던 Reactive Programming을 SwiftUI 환경에서 구현할 수 있게 도와주는 1st Party 프레임워크입니다. 단순 Reactive Programming을 넘어 Swift Concurrency를 이용한 비동기 작업도 한 번에 할 수 있도록 만들어졌기에 사용하였습니다.

### III. Image Caching 관련 프레임워크

- **Kingfisher**: Image Caching에 사용된 프레임워크입니다. 기존 FileManager 라이브러리를 사용해 Disk Cache를 직접 구현하였지만, 현업에서 많이 사용되고 있는 프레임워크이기 때문에 자체적인 Cache 라이브러리를 만들기보단 사용에 익숙해지고 싶어 사용하였습니다. Memory Cache도 구현할 예정이며, Disk Cache와 같이 먼저 NSCache를 사용해 구현해 본 후, 해당 프레임워크로 리팩토링 할 예정입니다.

### IV. 테스트 관련 프레임워크

- **XCTest**: 앱 유닛 테스트를 진행하기 위해 필요한 프레임워크입니다. Protocol Oriented Programming을 통해 만들어진 클래스를 Mock으로 만들어 주입시켜 유닛 테스트 케이스를 만들었으며, 92% 테스트 커버리지를 달성하였습니다. 

- **RxTest**: Observable을 테스트하기 위해 사용한 프레임워크입니다.

### V. 비동기 작업 관련 프레임워크

- **Swift Concurrency**: Grand Central Dispatch의 Dispatch Queue가 가지고 있는 치명적인 문제(Thread Explosion으로 인한 기능 저하, Thread 작업 취소 불가로 인한 Thread 관리 복잡도, Completion Handler 사용으로 가독성이 떨어지는 코드)를 Task란 개념으로 해결해 줄 수 있는 새로운 비동기 작업 방법입니다.

### VI. 프레임워크 Dependency 관리 툴

- **Swift Package Manager**: CocoaPods로 관리하기 힘들었던 프레임워크 간 Dependency 및 프레임워크 버전 관리를 손쉽게 1st Party 기능으로 해결할 수 있다는 장점덕에 사용하게 되었습니다.

# 4. 개발 중 난관 및 해결 방법
**I. 포켓몬 데이터를 서버로부터 받아오는 방법**: 개발 초기엔 검색 기능이 있는 도감의 특성상, 1000개가 넘는 포켓몬 엔트리를 한 번에 받아오는 것을 통해 모든 포켓몬을 검색할 수 있게 만들었지만, 테이블 뷰 셀 내부 이미지를 위해 너무 많은 네트워크 콜을 불러 빈번한 "HTTP Load Failed" 에러가 발생했습니다. 이를 해결하기 위해 한 번에 20개의 포켓몬 엔트리만을 받아올 수 있도록 Infinite Scroll을 구현하였습니다.

**II. 검색 기능**: 바뀐 포켓몬 데이터 로드 방식과 그를 위한 Infinite Scroll으로 인해 초기에 구상했던 전체 포켓몬 검색은 불가능해졌습니다. 검색이 시작되면 새로운 데이터를 로드하는 것을 중단하고, 이미 로드된 데이터 내에서만 검색을 실행하도록 검색 기능을 새롭게 구현하였습니다.

**III. GCD로 만들어진 Kingfisher 프레임워크 함수**: Kingfisher는 사용하기 편한 프레임워크이지만 문제는 오래전에 만들어졌다보니, Swift Concurrency를 지원하는 함수가 없습니다. 저는 이를 Continuation을 사용해 GCD를 사용하는 Kingfisher Disk Cache (ImageCache) 함수를 리팩토링하여 Swift Concurrency로 변환시켜 사용하였습니다.

**IV. 빠르게 스크롤 시 Placeholder인 포켓볼 이미지가 아닌 포켓몬 이미지 충돌**:

  -> **버그 내용**: Placeholder인 포켓볼 이미지는 로드가 되지 않은 이미지를 대신 해 나타나야 하지만, 밑의 gif를 보시면 포켓몬 이미지가 바뀌는 것을 보실 수 있습니다.

![scroll image bug](https://github.com/JinhoLee93/Portfolio/assets/60580427/b3cd2524-d195-4f38-aa85-7036f9de25c6) 

  -> **해결 방법**: Reusable Cell을 사용하는 테이블 뷰에서 전에 실행된 네트워크 작업이 완료되지 않은 상태로 셀이 다시 사용되는 과정에 이런 현상이 생기는 것임을 파악한 후, prepareForReuse() 함수 내 이미지를 로드하는 Task를 취소하는 코드를 아래와 같이 한 줄 넣어 해결하였습니다.

<img width="372" alt="Screenshot 2024-04-15 at 1 31 11 PM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/75d27e89-0e4c-45a5-91a1-1cd9b904876e">

  -> **결과**: 더 이상 이미지 충돌로 인해 깜빡거리는 현상이 발생하지 않았습니다.

![scroll image bug solved](https://github.com/JinhoLee93/Portfolio/assets/60580427/609d7143-9290-4c6a-9c2f-faaabaf22bb8)


**V. Controller에 Delegate과 Datasource Boilerplate 코드 없이 테이블 뷰 Customization**: 포켓몬 상세 데이터를 섹션 별로 나누기 위해 테이블 뷰를 Customize 해야 했는데, RxCocoa만으론 섹션이 나눠진 복잡한 테이블 뷰는 구현할 수 없었습니다. 모든 것을 Rx 형식으로 구현하는 것을 포기하고, Delegate과 DataSource를 사용하려고 했을 때, RxDatasource란 프레임워크가 있다는 것을 발견하였고, 그를 사용해 섹션이 나누어진 포켓몬 상세 데이터 테이블 뷰를 구현할 수 있었습니다.
   
  -> **결과**: 성공적으로 섹션별로 나뉜 포켓몬 상세 정보
    
<img width="407" alt="Screenshot 2024-04-15 at 1 51 56 PM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/2c362bf9-dd86-4bee-a682-184ca1f8329b">

**VI. ViewModel에서 포켓몬 데이터 PublishSubject에 담긴 기존 데이터를 다루고자 할 때 생기는 Nesting Subscribe 문제**: Nesting Subscribe은 데이터 스트림이 꼬이면서 무한히 Observable 갱신이 일어날 수 있어 피해야 하는 행동입니다. 유저가 특정 포켓몬에 좋아요를 눌렀을 때, 기존의 포켓몬 BehaviorSubject에 접근해 내부 데이터를 바꿔야 하는데, Nesting Subscribe 없인 할 수 없었습니다. 이를 해결하기 위해 RxRelay 프레임워크를 사용하였습니다.

**VII. POP와 Generic을 이용한 Unit Test**: Generic 함수를 이용해 Protocol을 만들고 해당 Protocol을 이용해 Mock Network Layer를 만든 후, Dependency Injection을 통해 Unit Test에 사용하였습니다.
  
  -> **Protocol 코드**:
  
<img width="882" alt="Screenshot 2024-04-16 at 11 07 57 AM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/4f7beff6-8467-4699-a80e-2bc2a4565d51">

  -> **Mock Layer 구성**: 
  
<img width="1483" alt="Screenshot 2024-04-16 at 11 09 39 AM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/5aeba1f4-c9c2-478d-aa2b-273dc7bff977">

**VIII. Unit Test Cases 제작에 대한 회고**: 스트레스 테스트를 돌릴 수 있을만큼 간단한 데이터를 사용하는 것과 이를 100% 활용할 수 있는 Pure Function 위주의 함수를 만드는 것이 최고의 테스트를 만드는 가장 쉬운 방법인 것 같습니다.
  
# 5. To-Do's
- [x] 제대로 된 Error Handling 구현
- [x] Combine을 통한 View 구조체 업데이트 시 RunLoop.main이 아닌 MainActor.run을 사용할 것
