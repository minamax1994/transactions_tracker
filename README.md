# Transactions Tracker
A Flutter mobile application for managing cards and transactions, built with clean architecture principles and modern Flutter development practices.

![Screenshot-1](https://github.com/user-attachments/assets/7a8dfb5a-d658-4da3-9c10-52497a06de57)

## Architecture Overview

### Clean Architecture

The application follows Clean Architecture with three main layers:

1. **Domain Layer**
   - Contains business logic and use cases
   - Defines abstract repositories
   - Pure Dart code with no dependencies on Flutter or external packages
   - Houses core business entities and validation rules

2. **Data Layer**
   - Implements repositories from the domain layer
   - Handles data sources (local and remote)
   - Manages data caching and network states
   - Implements error handling and data transformations

3. **Presentation Layer**
   - Uses BLoC pattern (via Cubit) for state management
   - Contains UI components and pages
   - Handles user input and state rendering
   - Implements navigation and form management

### Key Technical Decisions

- **State Management**: Flutter Bloc (Cubit) for its simplicity and testability
- **Dependency Injection**: GetIt for service location and dependency management
- **Local Storage**: Hive for efficient, lightweight local data persistence
- **Network Layer**: HTTP package for API communication
- **Error Handling**: Custom Failure classes with Either type from dartz
- **Code Generation**: Build Runner with JSON Serializable for model generation

## Setup Instructions

### Prerequisites

- Flutter SDK (3.29.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/transactions_tracker.git
cd transactions_tracker
```

2. Install dependencies:
```bash
flutter pub get
```

### Running Tests

```bash
flutter test
```

### Development Environment

Run the app in debug mode:
```bash
flutter run
```

## Project Structure

```
lib/
  ├── core/
  │   ├── di/
  │   └── error/
  ├── data/
  │   ├── data_sources/
  │   │   ├── local/
  │   │   └── remote/
  │   ├── models/
  │   └── repositories/
  ├── domain/
  │   ├── entities/
  │   ├── repositories/
  │   └── use_cases/
  ├── presentation/
  │   ├── bloc/
  │   │   ├── card/
  │   │   ├── cards/
  │   │   ├── transaction/
  │   │   └── transactions/
  │   ├── pages/
  │   │   ├── card_creation/
  │   │   ├── transaction/
  │   │   └── home/
  │   └── widgets/
  │       ├── common/
  │       ├── card_creation/
  │       └── home/
  └── main.dart
```

## Future Improvements

1. **Testing Coverage**
   - Increase unit test coverage to >80% (currently 70%)
   - Add integration tests for critical flows
   - Implement E2E tests using Flutter Driver

2. **Performance Optimization**
   - Implement pagination for transaction list
   - Add image caching
   - Optimize widget rebuilds

3. **Architecture Enhancements**
   - Add Router abstraction layer
   - Implement a proper logging system
   - Add analytics tracking

4. **Offline Capabilities**
   - Improve offline-first architecture
   - Add background sync
   - Implement conflict resolution

5. **UI Enhancements**
   - Add app launcher icon and logo
   - Add a bottom navigation bar to separate cards and transactions

6. **Additional Features**
   - Add login & registration
   - Allow multiple accounts
