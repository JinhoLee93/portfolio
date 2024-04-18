# PokeDex (포켓몬 도감)

# 1. 개요

[유튜브 링크](https://youtube.com/shorts/INwuXnbQ-xA)

RESTfulAPI를 통한 [PokeAPI](https://pokeapi.co/) 오픈소스 서버를 이용해 포켓몬 정보(Official Portrait, 이름, 타입, 기술 등)를 리스트 형식으로 유저에게 보여주고, 유저는 포켓몬을 저장하여 라이브러리를 통해 빠르게 볼 수 있습니다.

# 2. 개발 목적
열렬한 포켓몬 딱지 콜렉터로 유년 시절을 보낸 제작자 혹은 제작자와 같은 유년기를 보낸 유저에게 향수를 불러일으켜, 잠깐이라도 어릴 때의 기분 좋은 날을 상상하며 좋은 하루를 만들 수 있기를 바라며 개발을 시작하였습니다.

# 3. Tech Stack
## Architecture

<table width="1200px">
  <thead>
    <tr>
      <th width="400px">관련 분야</th>
      <th width="800px">이름</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center">개발 언어</td>
      <td align="center">Swift</td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)/README.md#%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4">디자인 패턴</a></td>
      <td align="center">MVVM-C & MVVM</td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)/README.md#%EA%B0%9C%EB%B0%9C-%EA%B8%B0%EC%88%A0">개발 기술</a></td>
      <td align="center">Protocol Oriented Programming, Dependency Injection</td>
    </tr>
  </tbody>
</table>

## 프레임워크

<table width="1200px">
  <thead>
    <tr>
      <th width="400px">관련 분야</th>
      <th width="800px">이름</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)/README.md#i-ui">UI</a></td>
      <td align="center">UIKit, SwiftUI, SnapKit</td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)/README.md#ii-reactive-programming">Reactive Programming</a></td>
      <td align="center">Rx, Combine</td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)/README.md#iii-image-caching">Image Caching</a></td>
      <td align="center">Kingfisher</td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)/README.md#iv-%ED%85%8C%EC%8A%A4%ED%8C%85">Testing</a></td>
      <td align="center">XCTest, RxTest</td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)/README.md#v-%EB%B9%84%EB%8F%99%EA%B8%B0-%EC%9E%91%EC%97%85">비동기 작업</a></td>
      <td align="center">Swift Concurrency</td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)/README.md#vi-%ED%94%84%EB%A0%88%EC%9E%84%EC%9B%8C%ED%81%AC-dependency">프레임워크 Dependency 관리</a></td>
      <td align="center">Swift Package Manager</td>
    </tr>
  </tbody>
</table>

# 4. Tech Stack 사용 목적

## Architecture

### 디자인 패턴

- **MVVM-C & MVVM**: 쉬운 디버깅과 테스트, 그리고 가독성 높은 코드를 만들면서 각 모듈(Model, View, ViewModel)마다 해야할 일이 정확히 정해진 Clean Architecture를 구현하기 위해 MVVM 디자인 패턴을 사용하였습니다.
  
### 개발 기술

- **Protocol Oriented Programming**: 하나의 Super Class를 만들고 상속을 통해 코드를 구현하기보단 그 자리에서 해당 코드에 무엇이 필요한지 정해놓고 그로부터 가지를 뻗어나가는 것이 제가 개발하는 방식과 잘 맞다고 생각되어 OOP가 아닌, 코드 레이아웃을 먼저 Protocol로서 만들어놓고 코드를 만들기 시작하였습니다.
  
- **Dependency Injection**: 코드 부분을 독립적으로 모듈화 시켜 줄어든 코드 간 의존성으로 리팩토링이 쉬워지고, 외부의 변화로부터 내부 코드를 지킬 수 있다는 장점이 있지만, 크기가 크지 않은 이 앱에선 주로 테스트를 위한 Mock Network Layer 주입을 위해 사용되었습니다.

## 프레임워크

### I. UI

- **UIKit**: 포켓몬 정보를 사전처럼 열거해 주는 테이블 뷰는 앱의 중심이 되는 뷰입니다. 제가 구상한 비전을 최대한 구현하기 위해 SwiftUI의 List로는 구현 불가능한 섹션간 Cell 이동과 같은 Customization을 제공하고 많은 양의 셀이 한 번에 로드되었을 때 생기는 잠재적 Performance 문제를 생각하지 않아도 되는 UIKit를 선택했습니다.
  - **실제로 SwiftUI의 LazyVStack을 사용한 List는 1000개의 데이터를 넣어 테스트를 진행했을 때 26%의 CPU를 사용했고, UIKit의 UITableView는 그에 반해 오직 5%의 CPU만을 사용했습니다.**
  
- **SnapKit**: 인터페이스 빌더 사용으로 생성되는 소스코드로 인한 문제를 크게 겪었던 저는, 처음 앱을 구상할 때부터 코드로 UI를 만들겠다는 결심을 했습니다. 해당 프레임워크는 NSLayoutConstraint를 사용했을 때 생기는 코드베이스가 지저분해지는 문제를 막아주고, 쉽게 Auto Layout을 구현할 수 있도록 도와주었습니다.
  
- **SwiftUI**: 유저가 저장한 마음에 드는 포켓몬을 카드로서 보여주는 뷰를 LazyVGrid를 통해 구현하기 위해 사용하였습니다. UIKit의 Collection View를 사용했다면 최적의 CPU 사용량과 Peformance를 만들어낼 수 있었지만, SwiftUI의 AsyncImage와 같은 새롭게 추가된 기능들을 사용해 보며 연습하고 싶어 SwiftUI를 선택하였습니다.
  - **[연구결과](https://kth.diva-portal.org/smash/get/diva2:1789094/FULLTEXT01.pdf)에 따르면 SwiftUI의 LazyVGrid는 동일한 데이터를 처리하는데 UIKit의 CollectionView보다 세 배 느렸습니다.**

### II. Reactive Programming
 
- **Rx (RxSwift, RxRelay, RxDataSource)**: UIKit를 통해 Reactive Programming과 MVVM 디자인 패턴을 구현하기 위해 꼭 필요한 Rx입니다. 총 세 개의 Rx 관련 프레임워크가 사용되었습니다.
  - **RxSwift**: Observable을 사용할 수 있게 해주는 가장 기본적인 프레임워크입니다. 앱 내부 대부분의 Reactive Programming은 Publish, Behavior Subjcet를 통해 구현되었습니다.
  - **RxRelay**: Behavior 타입의 Observable 내 데이터를 업데이트하고 싶을 때 사용되었습니다. 기존 BehaviorSubject를 사용했을 때 생기는 Nesting Subscribe 문제를 해결해 주었습니다.
  - **RxDataSource**: 완벽한 Reactive Programming을 구현하고 싶었기에 Delegate 혹은 Datasource 관련한 코드로 Controller를 채우고 싶지 않았지만, RxSwift를 통해 테이블 뷰를 Customize 하는 데엔 한계가 있었습니다. 해당 프레임워크는 그 문제를 해결해 주었습니다.
  
- **Combine**: Rx를 통해 할 수 있던 Reactive Programming을 SwiftUI 환경에서 구현할 수 있게 도와주는 1st Party 프레임워크입니다. 단순 Reactive Programming을 넘어 Swift Concurrency를 이용한 비동기 작업도 한 번에 할 수 있도록 만들어졌기에 사용하였습니다.

### III. Image Caching

- **Kingfisher**: Image Caching에 사용된 프레임워크입니다. 기존 FileManager 라이브러리를 사용해 Disk Cache를 직접 구현하였지만, 현업에서 많이 사용되고 있는 프레임워크이기 때문에 자체적인 Cache 라이브러리를 만들기보단 사용에 익숙해지고 싶어 사용하였습니다. Memory Cache도 구현할 예정이며, Disk Cache와 같이 먼저 NSCache를 사용해 구현해 본 후, 해당 프레임워크로 리팩토링 할 예정입니다.

### IV. 테스팅

- **XCTest**: 앱 유닛 테스트를 진행하기 위해 필요한 프레임워크입니다. Protocol Oriented Programming을 통해 만들어진 클래스를 Mock으로 만들어 주입시켜 유닛 테스트 케이스를 만들었으며, 92% 테스트 커버리지를 달성하였습니다. 

- **RxTest**: Observable을 테스트하기 위해 사용한 프레임워크입니다.

### V. 비동기 작업

- **Swift Concurrency**: Grand Central Dispatch의 Dispatch Queue가 가지고 있는 치명적인 문제(Thread Explosion으로 인한 기능 저하, Thread 작업 취소 불가로 인한 Thread 관리 복잡도, Completion Handler 사용으로 가독성이 떨어지는 코드)를 Task란 개념으로 해결해 줄 수 있는 새로운 비동기 작업 방법입니다.

### VI. 프레임워크 Dependency

- **Swift Package Manager**: CocoaPods로 관리하기 힘들었던 프레임워크 간 Dependency 및 프레임워크 버전 관리를 손쉽게 1st Party 기능으로 해결할 수 있다는 장점덕에 사용하게 되었습니다.

# 5. 개발 중 난관 및 해결 방법

## I. 1000개가 넘는 포켓몬 엔트리를 한 번에 받아올 시, 너무 많은 네트워크 콜로 인해 빈번하게 생기던 "HTTP Load Failed" 에러

- **해결 방법**: 이를 해결하기 위해 한 번에 20개의 포켓몬 엔트리만을 받아올 수 있도록 테이블 뷰 Infinite Scroll을 구현

## II. Infinite Scroll 구현으로 인해, 불가능해진 전체 포켓몬 검색

- **해결 방법**: 검색 시작 시, 새로운 포켓몬 로드 종료 후, 이미 로드 되어있는 포켓몬 내 검색 허용

## III. GCD로 만들어진 Kingfisher 프레임워크 함수

- **해결 방법**: Continuation을 통해 필요한 Disk Cache 함수 리팩토링

## IV. 빠르게 스크롤 시 Placeholder인 포켓볼 이미지가 아닌 포켓몬 이미지 충돌

- **버그 내용**: 전에 로드된 포켓몬 이미지가 재사용 셀에 남아있어 최근 포켓몬 이미지와 충돌하는 상황 발생

![scroll image bug](https://github.com/JinhoLee93/Portfolio/assets/60580427/b3cd2524-d195-4f38-aa85-7036f9de25c6) 

- **해결 방법**: 비동기 작업 및 재사용 셀 인과관계 파악 후, prepareForReuse() 함수 내 이미지를 로드하는 Task를 취소하는 코드를 아래와 같이 한 줄 넣어 해결

<img width="372" alt="Screenshot 2024-04-15 at 1 31 11 PM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/75d27e89-0e4c-45a5-91a1-1cd9b904876e">

- **결과**: 없어진 테이블 뷰 내 이미지 충돌

![scroll image bug solved](https://github.com/JinhoLee93/Portfolio/assets/60580427/609d7143-9290-4c6a-9c2f-faaabaf22bb8)


## V. Controller에 Delegate과 Datasource Boilerplate 코드 없이 테이블 뷰 Customization: 

포켓몬 상세 데이터를 섹션 별로 나누기 위해 테이블 뷰를 Customize 해야 했는데, RxCocoa만으론 섹션이 나눠진 복잡한 테이블 뷰는 구현할 수 없었습니다. 모든 것을 Rx 형식으로 구현하는 것을 포기하고, Delegate과 DataSource를 사용하려고 했을 때, RxDatasource란 프레임워크가 있다는 것을 발견하였고, 그를 사용해 섹션이 나누어진 포켓몬 상세 데이터 테이블 뷰를 구현할 수 있었습니다.
   
  -> **결과**: 성공적으로 섹션별로 나뉜 포켓몬 상세 정보
    
<img width="407" alt="Screenshot 2024-04-15 at 1 51 56 PM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/2c362bf9-dd86-4bee-a682-184ca1f8329b">

## VI. ViewModel에서 포켓몬 데이터 PublishSubject에 담긴 기존 데이터를 다루고자 할 때 생기는 Nesting Subscribe 문제

Nesting Subscribe은 데이터 스트림이 꼬이면서 무한히 Observable 갱신이 일어날 수 있어 피해야 하는 행동입니다. 유저가 특정 포켓몬에 좋아요를 눌렀을 때, 기존의 포켓몬 BehaviorSubject에 접근해 내부 데이터를 바꿔야 하는데, Nesting Subscribe 없인 할 수 없었습니다. 이를 해결하기 위해 RxRelay 프레임워크를 사용하였습니다.

## VII. POP와 Generic을 이용한 Unit Test

Generic 함수를 이용해 Protocol을 만들고 해당 Protocol을 이용해 Mock Network Layer를 만든 후, Dependency Injection을 통해 Unit Test에 사용하였습니다.
  
  -> **Protocol 코드**:
  
<img width="882" alt="Screenshot 2024-04-16 at 11 07 57 AM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/4f7beff6-8467-4699-a80e-2bc2a4565d51">

  -> **Mock Layer 구성**: 
  
<img width="1483" alt="Screenshot 2024-04-16 at 11 09 39 AM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/5aeba1f4-c9c2-478d-aa2b-273dc7bff977">

## VIII. Unit Test Cases 제작에 대한 회고

스트레스 테스트를 돌릴 수 있을만큼 간단한 데이터를 사용하는 것과 이를 100% 활용할 수 있는 Pure Function 위주의 함수를 만드는 것이 최고의 테스트를 만드는 가장 쉬운 방법인 것 같습니다.
  
# 6. To-Do's
- [x] 제대로 된 Error Handling 구현
- [x] Combine을 통한 View 구조체 업데이트 시 RunLoop.main이 아닌 MainActor.run을 사용할 것
