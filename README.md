# 이진호 개인 프로젝트 포트폴리오

# [1. PokeDex (포켓몬 도감)](https://github.com/JinhoLee93/Portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/d990771e-b0fc-4b15-aa63-7ef2800b8c0b" width="30">](https://youtube.com/shorts/INwuXnbQ-xA)

## I. 개요

RESTfulAPI를 통한 [PokeAPI](https://pokeapi.co/) 오픈소스 서버를 이용해 포켓몬 정보(Official Portrait, 이름, 타입, 기술 등)를 리스트 형식으로 유저에게 보여주고, 유저는 포켓몬을 저장하여 라이브러리를 통해 빠르게 볼 수 있습니다.

## [II. Tech Stack](https://github.com/JinhoLee93/portfolio/blob/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)/README.md#4-tech-stack-%EC%B1%84%ED%83%9D-%EC%9D%B4%EC%9C%A0)

### Architecture

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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#i-mvvm-c--mvvm">MVVM-C & MVVM</a></td>
    </tr>
    <tr>
      <td align="center">개발 기술</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#ii-protocol-oriented-programming">Protocol Oriented Programming</a>, <a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#iii-dependency-injection">Dependency Injection</a></td>
    </tr>
  </tbody>
</table>

### 프레임워크

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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#iv-uikit">UIKit</a>, <a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#v-snapkit">SnapKit</a>, <a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#vi-swiftui">SwiftUI</a></td>
    </tr>
    <tr>
      <td align="center">Reactive Programming</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#vii-rx-rxswift-rxrelay-rxdatasource">Rx</a>, <a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#viii-combine">Combine</a></td>
    </tr>
    <tr>
      <td align="center">Image Caching</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#ix-kingfisher">Kingfisher</a></td>
    </tr>
    <tr>
      <td align="center">Testing</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#x-xctest">XCTest</a>, <a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#xi-rxtest">RxTest</a></td>
    </tr>
    <tr>
      <td align="center">비동기 작업</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#xii-swift-concurrency">Swift Concurrency</a></td>
    </tr>
    <tr>
      <td align="center">프레임워크 Dependency 관리</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#xiii-swift-package-manager">Swift Package Manager</a></td>
    </tr>
  </tbody>
</table>

## III. 제작 기간
2024.02 ~

## IV. 기여도
100%

# [2. WordsADay (하루 단어)](https://github.com/JinhoLee93/portfolio/tree/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/d990771e-b0fc-4b15-aa63-7ef2800b8c0b" width="30">](https://www.youtube.com/shorts/XjecEqldjcY) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/efface9a-a782-4d8b-ae34-1e3ad5af1d19" width="28">](https://apps.apple.com/kr/app/%ED%95%98%EB%A3%A8-%EB%8B%A8%EC%96%B4/id6449736565?l=en)

## I. 개요

장소법을 개량한 암기 방법을 이용해 만든 하루 단어의 유저는 본인의 방법으로 단어를 외우고, 단어 게임을 통해 어디까지 학습했는지 체크할 수 있습니다.

## [II. Tech Stack](https://github.com/JinhoLee93/portfolio/blob/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)/README.md#4-tech-stack-%EC%B1%84%ED%83%9D-%EC%9D%B4%EC%9C%A0)

### Architecture

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

### 프레임워크

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

## III. 제작 기간
2022.03 ~ 2022.06

## IV. 기여도
100%

# [3. FortySeconds (하루 40초)](https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/d990771e-b0fc-4b15-aa63-7ef2800b8c0b" width="30">](https://youtu.be/3eXYfnBKCjE) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/efface9a-a782-4d8b-ae34-1e3ad5af1d19" width="28">](https://apps.apple.com/kr/app/%ED%95%98%EB%A3%A8-40%EC%B4%88/id1612627349?l=en)


## I. 개요

[Wordle](https://www.nytimes.com/games/wordle/index.html)로부터 감명받아 제작된 하루 40초는 하루에 단 4문제, 딱 40초만 플레이할 수 있는 한국어 단어 게임 앱입니다.

## [II. Tech Stack](https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)#4-tech-stack-%EC%B1%84%ED%83%9D-%EC%9D%B4%EC%9C%A0)

### Architecture

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

### 프레임워크

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

## III. 제작 기간
2022.02 ~ 2022.05

## IV. 기여도
100%

# Appendix
# [1. Bobidi Custom Buttom (@ Bobidi, Inc)](https://github.com/JinhoLee93/portfolio/tree/main/Bobidi%20Custom%20Button%20(%40%20Bobidi%2C%20Inc))

## I. 개요
[Bobidi, Inc에서 근무할 때 만든 Gradient 그래픽과 애니메이션이 들어간 Reactive 버튼입니다.](https://user-images.githubusercontent.com/60580427/233976614-848d97cc-51fd-424e-b70d-0afd744c5308.gif)

## [II. Tech Stack](https://github.com/JinhoLee93/portfolio/tree/main/Bobidi%20Custom%20Button%20(%40%20Bobidi%2C%20Inc)#4-tech-stack-%EC%B1%84%ED%83%9D-%EC%9D%B4%EC%9C%A0)

### Architecture

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
  </tbody>
</table>

### 프레임워크

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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/Bobidi%20Custom%20Button%20(%40%20Bobidi%2C%20Inc)#i-uikit">UIKit</a></td>
    </tr>
  </tbody>
</table>

## III. 제작 기간
2022.08.20 ~ 2022.08.21

## IV. 기여도
100%
