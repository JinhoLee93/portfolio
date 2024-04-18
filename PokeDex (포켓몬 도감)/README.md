# PokeDex (포켓몬 도감)

# 1. 개요

RESTfulAPI를 통한 [PokeAPI](https://pokeapi.co/) 오픈소스 서버를 이용해 포켓몬 정보(Official Portrait, 이름, 타입, 기술 등)를 리스트 형식으로 유저에게 보여주고, 유저는 포켓몬을 저장하여 라이브러리를 통해 빠르게 볼 수 있습니다.

**[유튜브 링크](https://youtube.com/shorts/INwuXnbQ-xA)**

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
      <td align="center">디자인 패턴</td>
      <td align="center">MVVM-C & MVVM</td>
    </tr>
    <tr>
      <td align="center">개발 기술</td>
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
      <td align="center">UI</td>
      <td align="center">UIKit, SwiftUI, SnapKit</td>
    </tr>
    <tr>
      <td align="center">Reactive Programming</td>
      <td align="center">Rx, Combine</td>
    </tr>
    <tr>
      <td align="center">Image Caching</td>
      <td align="center">Kingfisher</td>
    </tr>
    <tr>
      <td align="center">Testing</td>
      <td align="center">XCTest, RxTest</td>
    </tr>
    <tr>
      <td align="center">비동기 작업</td>
      <td align="center">Swift Concurrency</td>
    </tr>
    <tr>
      <td align="center">프레임워크 Dependency 관리</td>
      <td align="center">Swift Package Manager</td>
    </tr>
  </tbody>
</table>

# 4. Tech Stack 채택 이유

## I. MVVM-C & MVVM 

- 쉬운 디버깅과 테스트
- 가독성 높은 코드
- 각 모듈(Model, View, ViewModel)마다 해야할 일이 명확히 정해진 Clean Architecture 구현

## II. Protocol Oriented Programming

- Super Class 기능 확인을 위해 계속되는 페이지 이동으로 인해 낭비되는 시간
- 필요한 코드 레이아웃을 먼저 만듦으로써 쓸 데 없는 Property의 증가 방지
  
## III. Dependency Injection

- 의존성 감소를 통해 안전해진 코드베이스
- 모듈화를 통해 쉬워진 리팩토링 및 테스트

## IV. UIKit

- 테이블 뷰 섹션간 셀 이동과 같은 복잡한 Customization 제공
- SwiftUI의 List와 비교했을 때 월등한 Performance
  - **실제로 SwiftUI의 LazyVStack을 사용한 List는 1000개의 데이터를 넣어 테스트를 진행했을 때 26%의 CPU를 사용했고, UIKit의 UITableView는 그에 반해 오직 5%의 CPU만을 사용했습니다.**
  
## V. SnapKit

- 인터페이스 빌더 UI 소스코드 문제 해결을 위한 코드 식 UI의 AutoLayout의 손쉬운 구현에 필요
- NSLayoutConstraint 사용으로 인해 지저분해지는 코드베이스 방지
  
## VI. SwiftUI

- Combine의 task 및 AsyncImage 같은 비교적 최신의 편리한 기능
- Vs UIKit Performance 문제는 여전히 존재
  - **[연구결과](https://kth.diva-portal.org/smash/get/diva2:1789094/FULLTEXT01.pdf)에 따르면 SwiftUI의 LazyVGrid는 동일한 데이터를 처리하는데 UIKit의 CollectionView보다 세 배 느렸습니다.**
 
## VII. Rx (RxSwift, RxRelay, RxDataSource)

- UIKit 환경에서 Reactive Programming 및 MVVM 디자인 패턴 구현
  
## VIII. Combine

- SwiftUI에서 Reactive Programming 구현 및 task를 통한 간편한 비동기 작업

## IX. Kingfisher

- 현업에서 많이 사용
- 편리한 Image Caching (FileManager와 NSCache를 통해 먼저 Native로 Cache 구현 후 사용)


## X. XCTest

- XCode 내 테스팅 환경 제공 (92% 유닛 테스트 커버리지 달성)

## XI. RxTest 

- Observable을 테스트 할 수 있게 도와주는 API 제공

## XII. Swift Concurrency

- Grand Central Dispatch의 Dispatch Queue가 가지고 있는 치명적인 문제(Thread Explosion으로 인한 기능 저하, Thread 작업 취소 불가로 인한 Thread 관리 복잡도, Completion Handler 사용으로 가독성이 떨어지는 코드)를 Task란 개념으로 해결

## XIII. Swift Package Manager

- CocoaPods보다 쉽고 간편한 프레임워크 Dependency 관리
- 1st Party

# 5. 개발 중 난관 및 해결 방법

## I. 빈번하게 생기던 "HTTP Load Failed" 에러

- **발생 이유**: 1000개가 넘는 포켓몬 데이터를 한 번에 받아오면서 만들게 되는 너무 많은 네트워크 콜

- **해결 방법**: 한 번에 20개의 포켓몬 엔트리만 받아올 수 있도록 테이블 뷰 Infinite Scroll 구현

## II. Infinite Scroll 구현으로 인해, 불가능해진 전체 포켓몬 검색

- **해결 방법**: 검색 시작 시, 새로운 포켓몬 로드 종료 후, 이미 로드 되어있는 포켓몬 내 검색 허용

## III. GCD로 만들어진 Kingfisher 프레임워크 함수

- **해결 방법**: Continuation을 통해 필요한 Disk Cache 함수 리팩토링

## IV. 빠르게 스크롤 시 테이블 뷰 셀 내 포켓몬 이미지 충돌

- **발생 이유**: 바로 시작되지 않는 비동기 작업과 테이블 뷰에 사용되는 재사용 셀 인과관계

- **버그 내용**: 전에 로드된 포켓몬 이미지가 재사용 셀에 남아있어 최근 포켓몬 이미지와 충돌하는 상황 발생

![scroll image bug](https://github.com/JinhoLee93/Portfolio/assets/60580427/b3cd2524-d195-4f38-aa85-7036f9de25c6) 

- **해결 방법**: prepareForReuse() 함수 내 이미지를 로드하는 Swift Concurrency Task 취소 코드를 아래와 같이 한 줄 넣어 해결

<img width="372" alt="Screenshot 2024-04-15 at 1 31 11 PM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/75d27e89-0e4c-45a5-91a1-1cd9b904876e">

- **결과**: 없어진 테이블 뷰 내 이미지 충돌

![scroll image bug solved](https://github.com/JinhoLee93/Portfolio/assets/60580427/609d7143-9290-4c6a-9c2f-faaabaf22bb8)

## V. Controller에 Delegate과 Datasource Boilerplate 코드 없이 테이블 뷰 섹션 구현 

- **발생 이유**: 테이블 뷰 Customization에 대한 부족한 RxSwift 서포트

- **해결 방법**: RxDataSource 프레임워크 적극 활용
   
- **결과**: 섹션별로 나뉜 포켓몬 상세 정보 구현 성공
    
<img width="407" alt="Screenshot 2024-04-15 at 1 51 56 PM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/2c362bf9-dd86-4bee-a682-184ca1f8329b">

## VI. Nesting Subscribe

- **발생 이유**: PublishSubject 내 데이터 접근성

- **해결 방법**: BehaviorRelay를 사용해 Observable 내 데이터 바로 접근

## VII. POP, Generic 및 Dependency Injection을 이용한 Unit Test

- **해결 방법**: Protocol을 통해 Network Layer 정립, Mock Data Layer 제작, 및 Mock Data Layer 테스트 코드에 주입.

- **Protocol 코드**:
  
<img width="882" alt="Screenshot 2024-04-16 at 11 07 57 AM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/4f7beff6-8467-4699-a80e-2bc2a4565d51">

- **Mock Layer 구성**: 
  
<img width="1483" alt="Screenshot 2024-04-16 at 11 09 39 AM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/5aeba1f4-c9c2-478d-aa2b-273dc7bff977">

## VIII. Unit Test Cases 제작

- **해결 방법**: 스트레스 테스트를 돌릴 수 있는 간단한 데이터를 100% 활용할 수 있는 순수 함수 위주의 코드 작성

- **결과**: 92%의 유닛 테스트 코드 커버리지 달성
  
# 6. To-Do's
- [x] 제대로 된 Error Handling 구현
- [x] Combine을 통한 View 구조체 업데이트 시 RunLoop.main이 아닌 MainActor.run을 사용할 것
