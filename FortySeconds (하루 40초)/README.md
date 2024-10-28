# For the English version of this document, please refer to [THIS](https://github.com/JinhoLee93/portfolio/blob/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)/README(ENGLISH).md) instead.

# FortySeconds (하루 40초) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/d990771e-b0fc-4b15-aa63-7ef2800b8c0b" width="30">](https://youtu.be/3eXYfnBKCjE) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/efface9a-a782-4d8b-ae34-1e3ad5af1d19" width="28">](https://apps.apple.com/kr/app/%ED%95%98%EB%A3%A8-40%EC%B4%88/id1612627349?l=en)


# 1. 개요
[Wordle](https://www.nytimes.com/games/wordle/index.html)로부터 감명받아 제작된 하루 40초는 하루에 단 4문제, 딱 40초만 플레이할 수 있는 한국어 단어 게임 앱입니다.

![230x0w](https://github.com/JinhoLee93/portfolio/assets/60580427/951d1a38-9b8c-411c-a16f-33aee80ffdb8) ![230x0w (1)](https://github.com/JinhoLee93/portfolio/assets/60580427/62b988bf-e726-43f0-a700-cc2adb72dc71) ![230x0w (2)](https://github.com/JinhoLee93/portfolio/assets/60580427/25337303-b56a-4d9a-a00a-664b5cfc96eb) ![230x0w (3)](https://github.com/JinhoLee93/portfolio/assets/60580427/e903b505-40a8-44a8-915c-f54164c8659b)

# 2. 개발 목적
제가 미국 유학 생활을 끝마칠 때쯤, 미국은 Wordle 돌풍에 휩싸였습니다. 

제가 처음 접한 Wordle은 모든 사람이 쉽게 플레이할 수 있을 만큼 직관적이었고, 간단했으며, 하루에 단 한 번만 플레이할 수 있음에도 불구하고 강력한 중독성이 있었습니다. Wordle은 저에게 처음으로 간단함의 미학을 일깨워 주었고, 한국어로 비슷한 단어 게임을 만들어보고 싶은 열망을 선사해 주었습니다. 

자극적이고 선정적인 세상에서 한 문제당 10초씩, 하루에 40초만이라도 마음을 놓을 수 있는 편안한 공간을 유저에게 만들어주고 싶다는 생각을 하였고, 하루 40초 구상에 들어가게 되었습니다. 제가 첫 번째로 개발한 앱인 하루 40초는 제 시각에서 바라본 한국어 단어 게임 Wordle입니다. 하루 40초를 계기로 저는 iOS 앱 개발의 재미에 눈 뜨게 되었습니다.

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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)#i-mvvm">MVVM</a></td>
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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)#ii-swiftui">SwiftUI</a></td>
    </tr>
    <tr>
      <td align="center">Reactive Programming</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)#iii-combine">Combine</a></td>
    </tr>
    <tr>
      <td align="center">비동기 작업</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)#iv-swift-concurrency">Swift Concurrency</a></td>
    </tr>
  </tbody>
</table>


# 4. Tech Stack 채택 이유

## I. MVVM

- 가독성이 좋으면서 쉬운 디버깅과 테스트를 위한 코드 작성을 도와줌
- 각 모듈(Model, View, ViewModel)마다 해야할 일이 명확히 정해진 Clean Architecture 구현에 사용됨

## II. SwiftUI

- 단어 "게임"의 재미있는 애니메이션 부분을 쉽게 구현하기 위한 서포트 제공
- Preview를 통한 빠른 애니메이션 확인 가능
- MVVM을 쉽게 구현할 수 있게 도와주는 Property Wrapper(@Published, @StateObject, @ObservedObject 등) 제공
  
## III. Combine

- "하루 40초"의 게임 중 필요한 40초 게임 타이머와 게임 후 필요한 24시간 백그라운드 타이머를 Publisher로서 구현하는 것에 필요한 기능 제공

## IV. Swift Concurrency

- 코드의 가독성 향상
- Task.sleep() 함수를 이용한 만든 Swift Concurrency 헬퍼 함수를 통한 용이해진 비동기 UI 애니메이션 처리

# 5. 개발 중 난관 및 해결 방법
## I. 정답시 카드를 180도 넘겨짐에도 불구하고 위의 글자를 360도 넘기는 이펙트

- **구현 목표**

![Cards Being Flipped](https://github.com/JinhoLee93/Portfolio/assets/60580427/8d73bf1f-323f-4e22-9db6-561ba40589b4)

- **해결 방법 1**: 카드 360도 회전

- **해결 방법 1의 문제**: 너무 많은 비주얼 인풋으로 인해 유저에게 불쾌감을 줌

- **해결 방법 2**: 카드가 90도 회전 할 때 생기는 사각을 이용. 카드가 90도로 회전하는 순간 빠르게 카드 위 콘텐츠를 180도 한 번 더 회전. 즉, 카드 콘텐츠는 360도 회전하게 되는 결과 구현.

<img width="906" alt="Screenshot 2024-04-18 at 6 19 13 PM" src="https://github.com/JinhoLee93/portfolio/assets/60580427/d9d6f4ae-f3a9-49ea-b9a5-0ae056c59f66">

- **결과**: 구현 목표 달성

## 6. To-Do's
- [x] GCD에서 Swift Concurrency로 Migrate
