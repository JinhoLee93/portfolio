# [WordsADay (하루 단어)](https://apps.apple.com/kr/app/%ED%95%98%EB%A3%A8-%EB%8B%A8%EC%96%B4/id6449736565?l=en)

**[유튜브 링크](https://youtube.com/shorts/XjecEqldjcY)**

# 0. Tech Stack
**MVVM, Swift, SwiftUI, Core Data, Grand Central Dispatch**

# 1. 개요
장소법을 개량한 암기 방법을 이용해 만든 하루 단어의 유저는 본인의 방법으로 단어를 외우고 단어 게임을 통해 어디까지 학습했는지 체크할 수 있습니다.

# 2. 개발 목적
컬럼비아 대학교를 졸업한 제가 영어 공부를 하면서 배운 영어 단어를 효율적으로 외울 수 있는 방법을 앱으로 나타내, 많은 유저의 언어 학습 여정에 도움이 되기를 바라며 개발하였습니다.

# 3. 디자인 패턴, 개발 기술 및 프레임워크의 사용 목적
## 디자인 패턴
- **MVVM**: 각 모듈(Model, View, ViewModel)마다 해야할 일이 정확히 정해진 Clean Architecture를 구현하기 위해 MVVM 디자인 패턴을 사용하였습니다.

## 프레임워크

### I. UI 관련 프레임워크

- **SwiftUI**: 개발 당시 UIKit와 친숙하지 못해, SwiftUI로 개발을 시작하였습니다.

### II. 데이터베이스 관련 프레임워크

- **Core Data**: 로컬 스토리지를 OOP 방식의 데이터베이스로 사용할 수 있도록 도와주는 프레임워크입니다. 유저가 마음대로 단어 노트를 만들고, 삭제하고, 저장하며, 다른 날짜에 저장된 단어 노트에 접근하기 위해선 단어 노트 데이터를 저장하고 불러올 수 있는 로컬 데이터베이스가 필요했습니다. AppStorage 혹은 UserDefaults로는 복잡한 데이터 구조체를 저장할 수 없었기에, 3rd Party 데이터베이스 프레임워크보단 iOS에 대한 서포트가 확실한 1st Party 데이터베이스 프레임워크인 Core Data를 사용하였습니다.

### III. 비동기 작업 관련 프레임워크

- **Grand Central Dispatch**: 비동기 작업 자체가 그렇게 많이 사용되지 않았을뿐더러 모두 UI와 관련된 작업이기에, 비동기 작업을 Swift Concurrency보다 손쉽게 구현할 수 있는 GCD를 사용하였습니다.

# 4. 개발 중 난관 및 해결 방법
**I. Core Data 사용**: 이 전까지 데이터베이스를 다뤄보지 못한 저는 Core Data Entity를 만들고 Attribute를 정하는데 많은 어려움을 겪었습니다. 하지만 PersistentContainer를 MVVM 디자인 패턴의 모델로 생각하고 ViewModel을 구현해 내면 된다고 생각하니, 수월하게 이해할 수 있었습니다.

# 5. To-Do's
- [ ] GCD 및 코드 리팩토링
