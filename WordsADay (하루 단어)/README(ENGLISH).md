# WordsADay [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/d990771e-b0fc-4b15-aa63-7ef2800b8c0b" width="30">](https://www.youtube.com/shorts/XjecEqldjcY) [<img src="https://github.com/JinhoLee93/portfolio/assets/60580427/efface9a-a782-4d8b-ae34-1e3ad5af1d19" width="28">](https://apps.apple.com/kr/app/%ED%95%98%EB%A3%A8-%EB%8B%A8%EC%96%B4/id6449736565?l=en)

# 1. Overview

The user of "WordsADay," a vocabulary app created using an improved mnemonic method based on the method of loci, can memorize words in their own way and track their learning progress through word games.

![230x0w](https://github.com/JinhoLee93/portfolio/assets/60580427/a6cf1087-a397-4050-9af3-9d74995b28c8) ![230x0w (2)](https://github.com/JinhoLee93/portfolio/assets/60580427/61c2e6c6-15fe-430e-afc4-90da0ffbb0c5) ![230x0w (1)](https://github.com/JinhoLee93/portfolio/assets/60580427/a9146fe1-6b07-4227-b6d1-453c9224ffb4) ![230x0w (3)](https://github.com/JinhoLee93/portfolio/assets/60580427/c89e7379-df3a-4977-b621-1e56b90105e3)

In the "WordsADay" vocabulary app, you can register the words you want to memorize as you wish and engage in word games for efficient vocabulary learning!


# 2. Development Purpose

As a graduate of Columbia University, I developed this app to represent an efficient way to memorize English words I learned while studying the language, hoping to assist many users on their language learning journeys.

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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)#i-mvvm">MVVM</a></td>
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
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)#ii-swiftui">SwiftUI</a></td>
    </tr>
    <tr>
      <td align="center">Database</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/tree/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)#iii-core-data">Core Data</a></td>
    </tr>
    <tr>
      <td align="center">Asynchronous Operations</td>
      <td align="center"><a href="https://github.com/JinhoLee93/portfolio/blob/main/WordsADay%20(%ED%95%98%EB%A3%A8%20%EB%8B%A8%EC%96%B4)/README.md#iv-grand-central-dispatch">Grand Central Dispatch</a></td>
    </tr>
  </tbody>
</table>

# 4. Reasons for Choosing the Tech Stack

## I. MVVM

- Helps write code that is easy to read, debug, and test.
  
- Implements a clean architecture where tasks for each module (Model, View, ViewModel) are clearly defined.
  
## II. SwiftUI

- Supports easy implementation of animations needed for the word game.
  
- Allows for quick verification of animation results through previews.
  
## III. Core Data

- A local database is needed to enable users to create, save, delete, and access past notes with complex data structures.
  
- Transitioned local storage to an OOP-style database.
  
- A reliable first-party database framework created for iOS development.
  
## IV. Grand Central Dispatch

- Despite its drawbacks, it was used for convenient and fast asynchronous task implementation, considering the relatively few asynchronous operations in the app.
  
# 5. Challenges During Development and Solutions

## I. Using Core Data

- Reason for Occurrence: Spent a lot of time creating Core Data entities and determining internal attributes due to unfamiliarity with the framework.

- Solution: Learned through documentation how the PersistentContainer can function as a model within MVVM.

- Result: Made it possible to query desired notes using Core Data predicates created from entities and their internal attributes.
