# Bobidi Custom Button

![Screen Recording 2023-04-24 at 7 36 50 PM](https://user-images.githubusercontent.com/60580427/233976614-848d97cc-51fd-424e-b70d-0afd744c5308.gif)

# 1. 개요
Gradient 그래픽과 애니메이션이 들어간 Reactive 버튼입니다.

# 2. 개발 목적
저는 제가 몸 담았던 “바비디”라는 곳이 제 자신에게도 자랑스러운 것처럼, 다른 사람이 바비디라는 이름을 들었을 때 제가 느끼는 것과 같은 기분을 느낄 수 있도록 바비디만의 색깔을 온전히 담을 수 있는 트레이드 마크와 같은 것을 만들고 싶어 했습니다. 

이 트레이드 마크를 만드는 것에 대한 열정은 레거시 녹음버튼을 보았을 때, “아! 이 버튼이 바비디를 작지만 확실하게 표현할 수 있으면 얼마나 좋을까?”라는 생각과 함께 더욱 커졌고, 이 열정을 실행으로 옮겨 주말을 사용해 버튼을 디자인하고 구현해 보았습니다.

버튼 애니메이션은 iOS 비디오 촬영 버튼에서 영감을 받았습니다.

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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/Bobidi%20Custom%20Button%20(%40%20Bobidi%2C%20Inc)/README.md#i-ui-%EA%B4%80%EB%A0%A8-%ED%94%84%EB%A0%88%EC%9E%84%EC%9B%8C%ED%81%AC">UI</a></td>
      <td align="center">UIKit</td>
    </tr>
  </tbody>
</table>

# 4. Tech Stack 채택 이유
## I. UIKit
- CAGradientLayer에 사용되는 UIColor 제공 

# 5. 개발 중 난관 및 해결 방법
## I. Core Animation과 Core Graphics을 통한 뷰 구조체 구현

- **발생 이유**: 디테일 구현을 위한 Fine Tuning에 소모된 긴 시간
  
- **해결 방법**: Core Animation과 Core Graphics를 이용해 뷰 구조체를 만들 땐 UI에 대한 정확한 아이디어와 목표 설정 필요
