# FortySeconds [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/d990771e-b0fc-4b15-aa63-7ef2800b8c0b" width="30">](https://youtu.be/3eXYfnBKCjE) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/efface9a-a782-4d8b-ae34-1e3ad5af1d19" width="28">](https://apps.apple.com/kr/app/%ED%95%98%EB%A3%A8-40%EC%B4%88/id1612627349?l=en)

# 1. Overview

Inspired by Wordle, FortySeconds is a Korean word game app that allows you to play just 4 questions for only 40 seconds each day.

![230x0w](https://github.com/JinhoLee93/portfolio/assets/60580427/951d1a38-9b8c-411c-a16f-33aee80ffdb8) ![230x0w (1)](https://github.com/JinhoLee93/portfolio/assets/60580427/62b988bf-e726-43f0-a700-cc2adb72dc71) ![230x0w (2)](https://github.com/JinhoLee93/portfolio/assets/60580427/25337303-b56a-4d9a-a00a-664b5cfc96eb) ![230x0w (3)](https://github.com/JinhoLee93/portfolio/assets/60580427/e903b505-40a8-44a8-915c-f54164c8659b)

# 2. Development Purpose
As I was finishing my studies in the United States, the country was swept up in the Wordle craze.

The first time I encountered Wordle, I found it to be intuitive and simple enough for everyone to play, yet it had a strong addictive quality despite being limited to just one play per day. Wordle awakened in me an appreciation for the beauty of simplicity and sparked a desire to create a similar word game in Korean.

In a world filled with stimulation and sensationalism, I wanted to provide users with a comforting space where they could take a breather for at least 40 seconds a day, tackling just one problem at a time. This led me to conceptualize 하루 40초. My first developed app, FortySeconds, is my interpretation of a Korean word game akin to Wordle. Through this project, I discovered the joy of iOS app development.

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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)#i-mvvm">MVVM</a></td>
    </tr>
  </tbody>
</table>

## 프레임워크

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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)#ii-swiftui">SwiftUI</a></td>
    </tr>
    <tr>
      <td align="center">Reactive Programming</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)#iii-combine">Combine</a></td>
    </tr>
    <tr>
      <td align="center">Asynchronous Operations</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/FortySeconds%20(%ED%95%98%EB%A3%A8%2040%EC%B4%88)#iv-swift-concurrency">Swift Concurrency</a></td>
    </tr>
  </tbody>
</table>


# 4. Reasons for Tech Stack Adoption
## I. MVVM

- Helps in writing code that is readable and easy to debug and test.
  
- Used to implement Clean Architecture, with clearly defined responsibilities for each module (Model, View, ViewModel).
  
## II. SwiftUI

- Provides support for easily implementing fun animations in the word "game."

- Allows for quick animation previews.
  
- Offers Property Wrappers (such as @Published, @StateObject, @ObservedObject) that facilitate the implementation of MVVM.
  
## III. Combine

- Provides the necessary features for implementing the 40-second game timer and the 24-hour background timer after the game as Publishers.
  
## IV. Swift Concurrency

- Enhances code readability.
- Simplifies asynchronous UI animation handling through helper functions created with Swift Concurrency using the Task.sleep() function.

# 5. Development Challenges and Solutions

## I. Card Flipping Effect

- Challenge: The cards were supposed to flip 180 degrees, but they ended up flipping more than 360 degrees, causing the letters above to rotate excessively.

- Implementation Goal:

![Cards Being Flipped](https://github.com/JinhoLee93/Portfolio/assets/60580427/8d73bf1f-323f-4e22-9db6-561ba40589b4)

- Solution 1: Rotate the card 360 degrees.

- Problem with Solution 1: The excessive visual input caused discomfort for the user.

- Solution 2: Utilize the square created when the card rotates 90 degrees. At the moment the card is rotating 90 degrees, quickly rotate the content on the card an additional 180 degrees. This way, the content on the card ultimately appears to rotate 360 degrees.

<img width="906" alt="Screenshot 2024-04-18 at 6 19 13 PM" src="https://github.com/JinhoLee93/portfolio/assets/60580427/d9d6f4ae-f3a9-49ea-b9a5-0ae056c59f66">

## 6. To-Do's

- [x] Migrate from GCD to Swift Concurrency.
