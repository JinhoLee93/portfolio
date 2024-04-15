# PokeDex
**- 사용된 디자인 패턴: MVVM**
**- 사용된 개발 언어 및 프레임워크: Swift, UIKit, Rx, SnapKit, SwiftUI, Combine, Kingfisher, XCTest, RxTest, Swift Concurrency, Swift Package Manager**

## 1. 개요
RESTfulAPI를 통해 포켓몬 데이터를 전송해주는 PokeAPI 오픈소스 서버를 이용해 포켓몬 정보(Official Portrait, 이름, 타입, 기술 등)를 리스트 형식으로 유저에게 보여주고, 유저는 본인 마음에 드는 포켓몬을 저장하여 콜렉션 뷰 형태를 띈 라이브러리를 통해 빠르게 볼 수 있습니다.

## 2. 개발 목적
열렬한 포켓몬 딱지 콜렉터로 유년 시절을 보낸 제작자 혹은 제작자와 같은 유년기를 보낸 유저에게 향수를 불러일으켜, 잠깐이라도 어릴때의 기분 좋은 날을 상상하며 조금이라도 좋은 하루를 만들 수 있기를 바라며 개발을 시작하였습니다.

## 3. 프레임워크의 사용 목적
- **UIKit**: 포켓몬 정보를 사전처럼 열거해주는 테이블 뷰는 앱의 중심이 되는 뷰입니다. 제가 구상한 비전을 최대한 구현하기 위해 SwiftUI의 List로는 구현 불가능한 Customization을 제공하고 많은 양의 셀이 한 번에 로드 되었을 때 생기는 잠재적 Performance 문제를 생각하지 않아도 되는 UIKit를 선택했습니다.
  
- **Rx (RxSwift, RxRelay, RxDataSource)**: UIKit을 통해 Reactive Programming과 MVVM 디자인 패턴을 구현하기 위해 꼭 필요한 Rx입니다. 총 세 개의 Rx 관련 프레임워크가 사용되었습니다.
  - **RxSwift**: 가장 기본적인 Observable을 사용할 수 있게 해주는 프레임워크입니다. 앱 내부 대부분의 Reactive Programming은 Publish, Behavior Subjcet를 통해 구현되었습니다.
  - **RxRelay**: Behavior 타입의 Observable 내 데이터를 업데이트 하고싶을 때 사용되었습니다. 기존 BehaviorSubject를 사용했을 때 생기는 Nested Subscribe 문제를 해결해 주었습니다.
  - **RxDataSource**: 완벽한 Reactive Programming을 구현하고 싶었기에 Delegate 혹은 Datasource 관련한 코드로 Controller를 채우고 싶지 않았지만, RxSwift를 통해 테이블 뷰를 Customize하는데엔 한계가 있었습니다. RxSwift만을 사용하면 테이블 뷰에 섹션을 나눌 수 없었고, 해당 프레임워크는 그 문제를 해결해주었습니다.
  
- **SnapKit**: 인터페이스 빌더 사용으로 생성되는 소스코드로 인한 문제를 크게 겪었던 저는, 처음 앱을 구상할 때 부터 코드로 UI를 만들겠다는 결심을 했습니다. 해당 프레임워크는 NSLayoutConstraint를 사용했을 때 생기는 코드베이스가 지저분해지는 문제를 막아주고, 쉽게 Auto Layout을 구현할 수 있도록 도와주었습니다.
  
- **SwiftUI**: 유저가 저장한 마음에 드는 포켓몬을 카드로서 보여주는 뷰를 LazyVGrid를 통해 구현하기 위해 사용하였습니다. UIKit의 Collection View를 사용했다면 최적의 CPU 사용량과 Peformance를 만들어낼 수 있었지만, SwiftUI에 새롭게 추가 된 기능들을 사용해보며 연습하고싶어 SwiftUI를 선택하였습니다.
  
- **Combine**: Rx를 통해 할 수 있던 Reactive Programming을 SwiftUI 환경에서 구현할 수 있게 도와주는 1st Party 프레임워크입니다. 단순 Reactive Programming을 넘어 Swift Concurrency를 이용한 비동기 작업도 한번에 할 수 있도록 만들어졌기에 사용하였습니다.

- **Kingfisher**: Image Caching에 사용된 프레임워크입니다. 기존 FileManager 라이브러리를 사용해 Disk Cache를 직접 구현하였지만, 현업에서 많이 사용되고 있는 프레임워크이기 때문에 자체적인 Cache 라이브러리를 만들기보단 사용에 익숙해지고 싶어 사용하였습니다. Memory Cache도 구현할 예정이며, Disk Cache와 같이 먼저 NSCache를 사용해 구현해본 후, 해당 프레임워크로 리팩토링 할 예정입니다.

- **XCTest**: 앱 유닛 테스트를 진행하기 위해 필요한 프레임워크입니다. Protocol Oriented Programming을 통해 만들어진 클래스를 Mock으로 만들어 주입시켜 유닛 테스트 케이스를 만들었으며, 92% 테스트 커버리지를 달성하였습니다. 

- **RxTest**: Observable을 테스트하기 위해 사용한 프레임워크입니다.

- **Swift Concurrency**: Grand Central Dispatch의 Dispatch Queue가 가지고 있는 치명적인 문제(Thread Explosion으로 인한 기능 저하, Thread 작업 취소 불가로 인한 Thread 관리 복잡도, Completion Handler 사용으로 가독성이 떨어지는 코드)를 Task란 개념으로 해결해 줄 수 있는 새로운 비동기 작업 방법입니다.

- **Swift Package Manager**: CocoaPods로 관리하기 힘들었던 프레임워크간 Dependency 및 프레임워크 버전 관리를 손쉽게 1st Party 기능으로 해결할 수 있다는 장점덕에 사용하게 되었습니다.

## 4. 개발 중 난관 및 해결 방법
