# Employee Management App

A Flutter application for managing employee records with local database persistence, BLoC/Cubit state management, and a pixel-perfect UI matching the provided design.

## Features

- Add new employees with name, role, and employment dates
- View list of current and previous employees
- Edit employee details
- Delete employee records
- Persistent data storage using local database
- Responsive UI design for all mobile screen resolutions

## Tech Stack

- Flutter for cross-platform mobile development
- BLoC/Cubit for state management
- Hive for local data persistence for web, android and iOS
- Intl package for date formatting
- Flutter Calendar for date picking

## Project Structure

```
lib/
├── blocs/              # BLoC/Cubit state management
│   ├── employee_bloc/  # Employee management logic
│   └── theme_bloc/     # App theme management
├── data/
│   ├── models/         # Data models
│   ├── repositories/   # Repositories for data handling
│   └── services/       # Database and other services
├── ui/
│   ├── screens/        # App screens
│   ├── widgets/        # Reusable UI components
│   └── themes/         # App themes
|
├──utils/               # String constant values/utility methods
|
└── main.dart           # Entry point
```

## Setup and Installation

1. Ensure you have Flutter installed on your machine
2. Clone the repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  sqflite: ^2.3.0
  path: ^1.8.3
  intl: ^0.18.1
  flutter_slidable: ^3.0.0
```

## Screenshots



## Implementation Details

### Employee Management
- The app uses a Hive database to store employee information
- BLoC pattern is implemented for state management
- CRUD operations are available for employee records

### UI Components
- Custom calendar widget that matches the design
- Role selection bottom sheet
- Employee list with separate sections for current and previous employees
- Slidable list items for delete functionality

### Data Structure
Employee data model includes:
- Name
- Role
- Start date
- End date (optional)
