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
1. [Introduction](#Introduction)
2. [Features](#Features)
3. [Getting Started](#Getting-Started)
4. [Installation](#Installation)
5. [Project Structure](#Project-Structure)
6. [Modifications](#Modifications)
7. [References](#References)

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
   git clone https://github.com/rizallfrm/To-Do-List-App.git
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

5. **Project Structure**:
   ```
   lib/
   ├── data/
   │   └── hive_data_store.dart            # Manages Hive database setup and data storage
   ├── extensions/
   │   └── space_exs.dart                  # Custom extensions for spacing and layout
   ├── models/
   │   ├── task.dart                       # Task model definition
   │   └── task.g.dart                     # Generated code for Hive task model
   ├── utils/
   │   ├── app_colors.dart                 # Color constants used in the app
   │   ├── app_str.dart                    # String constants
   │   ├── constants.dart                  # General constants
   │   └── developer.dart                  # Development utilities
   ├── view/
   │   ├── home/
   │   │   ├── components/                 # UI components for the home screen
   │   │   │   ├── fab.dart                # Floating action button
   │   │   │   ├── home_app_bar.dart       # Custom app bar for the home screen
   │   │   │   └── slider_drawer.dart      # Navigation drawer component
   │   │   ├── widgets/                    # Widgets used in the home screen
   │   │   │   ├── data_record.dart        # Displays record details for tasks
   │   │   │   ├── data_store.dart         # Widget to manage task storage
   │   │   │   ├── details.dart            # Displays task details
   │   │   │   ├── home_view.dart          # Main home screen view
   │   │   │   ├── splash_view.dart        # Splash screen view
   │   │   │   ├── task_view_appbar.dart   # App bar for task view screen
   │   │   │   ├── task_view.dart          # Task view screen
   │   │   │   └── task_widget.dart        # Widget for displaying a single task
   │   ├── tasks/
   │   │   ├── date_time_selection.dart    # Date and time picker for tasks
   │   │   ├── rep_textfield.dart          # Reusable text field widget
   │   │   ├── notifikasi.dart             # Notification management
   │   │   └── record_detail_page.dart     # Page displaying task record details
   └── main.dart                           # Main entry point of the application

6. **Modifications**:

   This project includes several modifications beyond the original tutorial:
   - **Record Details**: Tracks additional metadata for each task, such as the creator, last modified time, and modification history.
   - **Notifications**: Sends notifications when new tasks are added, helping users stay informed about updates.
7. **References**:
   ```
   Youtube : https://www.youtube.com/watch?v=ACpq1B_R6dw&list=PLWhSmdyhZUVSZBXZUEUNQnEPZwrhzMz_H
   GitHub  : https://github.com/AmirBayat0/ 