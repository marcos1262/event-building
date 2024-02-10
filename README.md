# EventBuilding

<img src="https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white">

> An iOS app that lists Crypto coins Exchanges and shows its details, with loading state and error handling.

## User Story Description

As a user using the Event Building Inc. application, I would like to perform specific tasks in my event such as hiring staff, decorations, catering, etc.

You are tasked with creating a sample screen from the Event Building Inc. application that allows the user to select the task they want.
All tasks are categorized under different categories like (Staff, Food, Catering ..etc).
As such, the user selects a category and should be able to see all the items under this category.
Each item in the category may be included in multiple categories, and other items will only be included in one category.

## Functional Requirements

- Each category should have a title and an image.
- Each item in a category should have a title, minBudget, maxBudget, avgBudget, and an image. The app should list all categories and fetch them from GET
https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/categories.json
- When a user clicks on a specific group, the app should fetch the item for that category using
https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/categories/{categoryId}.json
- The app should show the category title and image along with each item’s title, image, minBudget, maxBudget, and whether it has been added to the user's items or not.
- Users should not be able to add the same item twice from the same category or different categories.
- On the categories list, display a label to show the average cost of all added items. The average should be calculated using the summation of avgBudget for each item.
- If the user has added any item, display a button to mark that item is added.

## 📱 Screenshots

<img width="200" src="https://github.com/marcos1262/event-building/blob/main/screenshot1.png">        <img width="200" src="https://github.com/marcos1262/event-building/blob/main/screenshot2.png">        <img width="200" src="https://github.com/marcos1262/event-building/blob/main/screenshot3.png">        <img width="200" src="https://github.com/marcos1262/event-building/blob/main/screenshot4.png">        <img width="200" src="https://github.com/marcos1262/event-building/blob/main/screenshot5.png">

## 👩🏾‍💻 Technologies
- [x] SwiftUI supporting iOS 14
- [x] MVVM Architecture
- [x] Combine
- [x] Unit test for ViewModel - Quick, Nimble
- [x] UI Test - XCTest
- [x] SPM - Swift Package Manager
- [x] Converted third-party CleanNetwork Async-await to Combine
- [x] Loaded images - KingFisher
- [x] Localized strings for en and pt-BR
