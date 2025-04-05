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
│   ├── employee/  # Employee management logic
│   └── custom_date_picker/     # Date picker logic
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
  flutter_bloc: ^9.1.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.1.1
  intl: ^0.20.2
  flutter_svg: ^2.0.17
  equatable: ^2.0.7
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
