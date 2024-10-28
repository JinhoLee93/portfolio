# PokeDex [<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/60580427/323625261-d990771e-b0fc-4b15-aa63-7ef2800b8c0b.svg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20241028%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241028T090005Z&X-Amz-Expires=300&X-Amz-Signature=3480f26acc8a54fad4a42dd5abd52baf33032eb6fb449b1defeb2d0cbf1d8aaf&X-Amz-SignedHeaders=host" width="30">](https://youtube.com/shorts/INwuXnbQ-xA)

# 1. Overview

Using the RESTful open-source server PokeAPI, this displays Pokémon information (official portrait, name, type, abilities, etc.) to users in a list format. Users can save Pokémon to quickly view them through a library.

![Simulator Screenshot - iPhone 15 Pro Max - 2024-04-19 at 17 46 39](https://github.com/JinhoLee93/portfolio/assets/60580427/50ccd5fb-25a9-464c-a6d8-6b2eb71b7f85) ![Simulator Screenshot - iPhone 15 Pro Max - 2024-04-19 at 17 47 38](https://github.com/JinhoLee93/portfolio/assets/60580427/747ee139-e4a7-4ebb-ae70-1b1c818695a2)
 ![Simulator Screenshot - iPhone 15 Pro Max - 2024-04-19 at 17 46 18](https://github.com/JinhoLee93/portfolio/assets/60580427/66e82921-1a5b-40a6-850a-654215de3082) ![Simulator Screenshot - iPhone 15 Pro Max - 2024-04-19 at 17 46 43](https://github.com/JinhoLee93/portfolio/assets/60580427/bac2e222-a13a-464f-94cf-549021c57fc6) 

![Screen Recording 2024-04-28 at 11 18 52 PM](https://github.com/JinhoLee93/portfolio/assets/60580427/4f916758-b57e-427d-89c3-b2ca6520bfef)

# 2. Development Purpose

The development was initiated with the hope of bringing nostalgia to the creator, a passionate childhood Pokémon card collector, and to users who shared a similar childhood. The aim is to let them imagine those happy days, even if just for a moment, and help make their day a little brighter.

# 3. Tech Stack
## Architecture

<table width="1200px">
  <thead>
    <tr>
      <th width="400px">Field</th>
      <th width="800px">Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center">Programming Language</td>
      <td align="center">Swift</td>
    </tr>
    <tr>
      <td align="center">Design Pattern</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#i-mvvm">MVVM</a></td>
    </tr>
    <tr>
      <td align="center">Development Technique</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#ii-protocol-oriented-programming">Protocol Oriented Programming</a>, <a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#iii-dependency-injection">Dependency Injection</a></td>
    </tr>
  </tbody>
</table>

## Framework

<table width="1200px">
  <thead>
    <tr>
      <th width="400px">Field</th>
      <th width="800px">Name</th>
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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#x-xctest">XCTest</a>, <a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#xi-rxblocking">RxBlocking</a></td>
    </tr>
    <tr>
      <td align="center">Asynchronous Operations</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#xii-swift-concurrency">Swift Concurrency</a></td>
    </tr>
    <tr>
      <td align="center">Framework Dependency Management</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#xiii-swift-package-manager">Swift Package Manager</a></td>
    </tr>
    <tr>
      <td align="center">Database</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/PokeDex%20(%ED%8F%AC%EC%BC%93%EB%AA%AC%20%EB%8F%84%EA%B0%90)#xiv-core-data">Core Data</a></td>
    </tr>
  </tbody>
</table>

# 4. Reasons for Tech Stack Choices
## I. MVVM

- Supports writing clean, easily readable code, which facilitates debugging and testing.

- Enables a clear implementation of Clean Architecture by defining specific responsibilities for each module (Model, View, ViewModel).

## II. Protocol Oriented Programming

- Prevents unnecessary property proliferation by designing the code layout in advance.

- Eliminates time wasted navigating between pages to verify superclass functionality, as seen with OOP.

## III. Dependency Injection

- Reduces dependency to create a codebase that is secure against external changes.
  
- Simplifies refactoring and testing through modularized code.
  
## IV. UIKit

- Provides complex customization, like moving cells between table view sections.

- Delivers significantly better CPU performance compared to SwiftUI’s List.
 
- For example, using SwiftUI’s LazyVStack-based List with 1,000 data entries showed a CPU usage of 26%, whereas UIKit’s UITableView only used 5% CPU.
  
## V. SnapKit

- Required for easy implementation of AutoLayout in code-based UIs to resolve issues with Interface Builder UI source code.
 
- Prevents the codebase from becoming cluttered due to NSLayoutConstraint usage.
  
## VI. SwiftUI

- Allows the use of convenient, newer features like AsyncImage.

- However, it still has performance limitations compared to UIKit.
  
- According to a study, SwiftUI’s LazyVGrid consumed three times more CPU than UIKit’s CollectionView when handling the same data.

## VII. Rx (RxSwift, RxRelay, RxDataSource)

- Utilized to implement Reactive Programming and the MVVM design pattern in the UIKit environment.

## VIII. Combine
 
- Used for implementing Reactive Programming in SwiftUI.

## IX. Kingfisher

- A widely-used framework in the industry.

- Provides convenient image caching capabilities (initially tested using FileManager and NSCache for native caching, then switched to Kingfisher).

## X. XCTest

- Provides a testing environment within Xcode (achieved 92% unit test coverage).

## XI. RxBlocking

- Enables testing of Observables.

## XII. Swift Concurrency

- Solves the critical issues with Dispatch Queues in Grand Central Dispatch (e.g., performance degradation due to thread explosion, complexity in thread management due to inability to cancel thread operations, and readability issues caused by completion handlers) with the concept of Tasks.

## XIII. Swift Package Manager

- A simpler and more user-friendly tool than CocoaPods for managing framework dependencies.

- A reliable 1st-party tool.

## XIV. Core Data

- Used to implement the local database.

# 5. Development Challenges and Solutions
   
## I. Frequent “HTTP Load Failed” Error

- Cause: The large number of network calls created by attempting to load over 1,000 Pokémon entries at once.

- Solution: Implemented Infinite Scroll in the table view to load only 20 Pokémon entries at a time.

- Outcome: The “HTTP Load Failed” error no longer occurs.

## II. Inability to Search All Pokémon Due to Infinite Scroll

- Solution: Enabled search within already-loaded Pokémon after new Pokémon loading has ended.

## III. GCD-Based Functions in the Kingfisher Framework

- Solution: Refactored necessary disk cache functions using Continuation.

- Outcome: Made GCD functions usable within Swift Concurrency.

## IV. Pokémon Image Conflicts in TableView Cells During Fast Scrolling

- Cause: Asynchronous tasks not starting immediately and the relationship between reused cells in the table view.

- Bug Details: Previously loaded Pokémon images remained on reused cells, causing conflicts with the latest Pokémon images, as shown below.

![scroll image bug](https://github.com/JinhoLee93/Portfolio/assets/60580427/b3cd2524-d195-4f38-aa85-7036f9de25c6) 

- Solution: Added a single line of code in the prepareForReuse() function within the table view cell to cancel the Swift Concurrency Task responsible for loading images, as shown below.

<img width="372" alt="Screenshot 2024-04-15 at 1 31 11 PM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/75d27e89-0e4c-45a5-91a1-1cd9b904876e"> 

- Result: The image conflict within the table view was resolved, as shown below.

![scroll image bug solved](https://github.com/JinhoLee93/Portfolio/assets/60580427/609d7143-9290-4c6a-9c2f-faaabaf22bb8)

## V. Implementing Table View Sections Without Delegate and Datasource Boilerplate Code in the Controller

- Cause: Limited RxSwift support for table view customization

- Solution: Actively utilized the RxDataSource framework

- Result: Successfully implemented detailed Pokémon information, organized by section as shown below

<img width="407" alt="Screenshot 2024-04-15 at 1 51 56 PM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/2c362bf9-dd86-4bee-a682-184ca1f8329b">

## VI. Nesting Subscriptions

- Cause: Accessing data within RxSwift's BehaviorSubject required using subscribe() within another subscribe(), leading to nested subscriptions.
  
- Solution: Switched to BehaviorRelay from RxRelay, allowing direct access to data via the .value property without needing subscribe().
  
- Result: Eliminated nested subscriptions, reducing the risk of tangled Observable data streams.
  
## VII. Unit Testing with POP, Generics, and Dependency Injection

- Solution: Defined the Network Layer through protocols, created a Mock Data Layer, and injected the Mock Data Layer into the test code.
 
- Protocol Code:

<img width="882" alt="Screenshot 2024-04-16 at 11 07 57 AM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/4f7beff6-8467-4699-a80e-2bc2a4565d51">

- Mock Layer Structure:

<img width="1483" alt="Screenshot 2024-04-16 at 11 09 39 AM" src="https://github.com/JinhoLee93/Portfolio/assets/60580427/5aeba1f4-c9c2-478d-aa2b-273dc7bff977">

- Result: All network-related properties are now testable.
  
## VIII. Creation of Unit Test Cases

- Solution: Wrote code primarily focused on pure functions, maximizing simple data usage for stress testing.
  
- Result: Achieved 95% unit test code coverage.
  
## IX. Implementation of Loading Icon

![Screen Recording 2024-04-28 at 11 18 52 PM](https://github.com/JinhoLee93/portfolio/assets/60580427/4f916758-b57e-427d-89c3-b2ca6520bfef)


## X. Sharing Data from Multiple ViewModels in a Single View

- Solution: Used SwiftUI’s environmentObject to share ViewModel data across views.
  
# 6. To-Do's
- [x] Implement comprehensive error handling
- [x] Use MainActor.run instead of RunLoop.main for View struct updates via Combine
- [x] Implement memory caching with NSCache
- [x] Add an animated loading icon
- [x] Implement and deploy a loading page
