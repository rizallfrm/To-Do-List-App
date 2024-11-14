# To Do List_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Flutter To-Do App with Record Details and Notifications
----

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Getting Started](#getting-started)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Project Structure](#project-structure)
7. [Additional Features](#additional-features)
8. [References](#references)
9. [License](#license)

---

## Introduction

This project is a Flutter-based To-Do application inspired by [this YouTube tutorial series](https://www.youtube.com/watch?v=ACpq1B_R6dw&list=PLWhSmdyhZUVSZBXZUEUNQnEPZwrhzMz_H). It allows users to create and manage tasks with persistent storage using Hive, a local NoSQL database. Additionally, it includes new features like recording task details and sending notifications when new tasks are added.

## Features

- **CRUD Operations**: Create, Read, Update, and Delete tasks in a to-do list.
- **Persistent Data Storage**: Uses Hive to locally store data on the device.
- **Record Details**: Tracks metadata for each task, such as who created or modified it.
- **Notifications**: Sends notifications when a new task is added.

## Getting Started

To set up this project on your local machine, you’ll need to have Flutter installed.

### Prerequisites

- **Flutter SDK**: Ensure you have Flutter installed. You can download it from [Flutter's official website](https://flutter.dev/).
- **Hive**: This project uses Hive for local data storage.

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
2. **Install dependencies**:
   ```flutter pub get ```

3. **Set up Hive database**:
   ```bash
      void main() async {
       await Hive.initFlutter();
       runApp(MyApp());
      }
4. **Run the application**:
   ```flutter run```
