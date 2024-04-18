# WordsADay (하루 단어) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/d990771e-b0fc-4b15-aa63-7ef2800b8c0b" width="30">](https://www.youtube.com/shorts/XjecEqldjcY) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/efface9a-a782-4d8b-ae34-1e3ad5af1d19" width="28">](https://apps.apple.com/kr/app/%ED%95%98%EB%A3%A8-%EB%8B%A8%EC%96%B4/id6449736565?l=en)

# 1. 개요
장소법을 개량한 암기 방법을 이용해 만든 하루 단어의 유저는 본인의 방법으로 단어를 외우고 단어 게임을 통해 어디까지 학습했는지 체크할 수 있습니다.

# 2. 개발 목적
컬럼비아 대학교를 졸업한 제가 영어 공부를 하면서 배운 영어 단어를 효율적으로 외울 수 있는 방법을 앱으로 나타내, 많은 유저의 언어 학습 여정에 도움이 되기를 바라며 개발하였습니다.

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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)#i-mvvm">MVVM</a></td>
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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)#ii-swiftui">SwiftUI</a></td>
    </tr>
    <tr>
      <td align="center">데이터베이스</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)#iii-core-data">Core Data</a></td>
    </tr>
    <tr>
      <td align="center">비동기 작업</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)/README.md#iv-grand-central-dispatch">Grand Central Dispatch</a></td>
    </tr>
  </tbody>
</table>

# 4. Tech Stack 채택 이유

## I. MVVM

- 가독성이 좋으면서 쉬운 디버깅과 테스트를 위한 코드 작성을 도와줌
- 각 모듈(Model, View, ViewModel)마다 해야할 일이 명확히 정해진 Clean Architecture 구현

## II. SwiftUI

- 단어 게임에 필요한 애니메이션의 쉬운 구현을 위한 기능 지원
- Preview를 통한 빠른 애니메이션 결과물 확인

## III. Core Data

- 유저가 복잡한 데이터 구조를 가진 단어 노트를 생성, 저장, 삭제 및 과거 노트 접근 할 수 있게 해주는 로컬 데이터베이스 필요
- 로컬 스토리지를 OOP 방식의 데이터베이스로의 전환
- iOS 개발을 위해 만들어져 Reliable한 1st Party 데이터베이스 프레임워크

## IV. Grand Central Dispatch

- 단점이 많지만, 앱 내 많지 않은 비동기 작업의 숫자를 감안하여 편리하고 빠른 비동기 작업 구현을 위해 사용

# 5. 개발 중 난관 및 해결 방법
## I. Core Data 사용

- **발생 이유**: 해당 프레임워크에 대한 미숙한 지식으로 인해 Core Data Entity 생성 및 내부 Attribute 결정 시 많은 시간 소모

- **해결 방법**: PersistentContainer가 어떻게 MVVM 내의 Model로서 역할을 할 수 있는지 문서 공부를 통해 알게 됨

- **결과**: Entity와 그것의 내부 Attribute를 통해 만든 Core Data Predicate 사용으로 원하는 노트를 Query로 불러오기 가능

# 6. To-Do's
- [x] 새로운 iPhone 환경에서 정상 작동하는지 테스트
