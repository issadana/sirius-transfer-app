# SIRIUS Transfer App

![Flutter](https://img.shields.io/badge/Flutter-3.24.5-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.5.4-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)
[![Code Quality](https://img.shields.io/badge/Maintainability-85%2F100-brightgreen)]()

**A cross-wallet transfer application built with Flutter**

Demonstrating clean architecture, modern state management, and enterprise-grade best practices

---

## Overview

SIRIUS Transfer App is a mobile application that enables money transfers between different wallet types. Built with Flutter and following clean architecture principles, it showcases production-ready code quality, comprehensive state management, and reusable component design.

### Key Highlights

- **Clean Architecture** - Clear separation of concerns with presentation, domain, and data layers
- **BLoC Pattern** - Robust state management with `flutter_bloc` and `freezed`
- **19+ Reusable Widgets** - Modular, testable components following DRY principles
- **Real-time Calculations** - Automatic fee computation and total display
- **Comprehensive Error Handling** - Graceful error states with retry functionality
- **Testable Code** - Components designed for unit and widget testing

---

## Features

### Core Functionality

**Transfer Management**

- Create new wallet-to-wallet transfers
- View transfer history with sorting
- Detailed transfer information display
- Real-time fee calculation (2%)

**User Experience**

- Intuitive form validation
- Loading states during operations
- Empty states for new users
- Error states with retry capability
- Pull-to-refresh on lists

**Transfer Details**

- Status visualization with color coding
- Amount breakdown (amount, fee, total)
- Transfer route display (from → to)
- Receiver information
- Optional notes support

### Status Types

- 🟢 **Completed** - Successfully processed transfers
- 🟡 **Pending** - Awaiting processing
- 🔵 **Processing** - Currently being processed
- 🔴 **Failed** - Failed transfers with error details

---

## Architecture

This project implements **Clean Architecture** with clear separation of concerns:

```
lib/
├── core/                         # Shared application resources
│   ├── api/                      # API configuration
│   ├── config/                   # Application configuration
│   ├── cubit/                    # Base cubit classes
│   ├── errors/                   # Error handling
│   ├── injection/                # Dependency injection
│   ├── resources/                # App-wide resources
│   ├── router/                   # Navigation configuration
│   └── utils/                    # Utility classes
│
├── features/
│   └── transfer/                # Transfer feature module
│       ├── data/
│       │   ├── models/          # Data models
│       │   └── repositories/    # Data repositories
│       ├── domain/
│       │   └── entities/        # Business entities
│       └── presentation/
│           ├── cubit/           # State management
│           ├── screens/         # Screen widgets
│           └── widgets/         # Reusable widgets
│
└── main.dart                    # Application entry point
```

### Architectural Layers

#### **Presentation Layer**

- **Screens**: Top-level route widgets
- **Widgets**: Reusable UI components
- **Cubit**: State management with BLoC pattern
- **Responsibility**: UI rendering and user interaction

#### **Domain Layer**

- **Entities**: Core business objects
- **Use Cases**: Business logic (if needed)
- **Responsibility**: Business rules and logic

#### **Data Layer**

- **Models**: Data transfer objects
- **Repositories**: Data access abstraction
- **Data Sources**: API clients, local storage
- **Responsibility**: Data fetching and persistence

---

## Tech Stack

### Core Framework

| Technology  | Version | Purpose              |
| ----------- | ------- | -------------------- |
| **Flutter** | 3.38.2  | UI framework         |
| **Dart**    | 3.10.0  | Programming language |

### State Management

| Package              | Version | Purpose                     |
| -------------------- | ------- | --------------------------- |
| `flutter_bloc`       | ^8.1.3  | BLoC state management       |
| `freezed`            | ^2.4.5  | Immutable state classes     |
| `freezed_annotation` | ^2.4.1  | Code generation annotations |

### Dependency Injection

| Package      | Version | Purpose         |
| ------------ | ------- | --------------- |
| `injectable` | ^2.3.2  | DI annotations  |
| `get_it`     | ^7.6.4  | Service locator |

### Navigation

| Package     | Version | Purpose             |
| ----------- | ------- | ------------------- |
| `go_router` | ^12.1.3 | Declarative routing |

### Network & Data

| Package           | Version | Purpose                |
| ----------------- | ------- | ---------------------- |
| `dio`             | ^5.4.0  | HTTP client            |
| `dartz`           | ^0.10.1 | Functional programming |
| `json_annotation` | ^4.8.1  | JSON serialization     |

### Utilities

| Package     | Version | Purpose              |
| ----------- | ------- | -------------------- |
| `intl`      | ^0.18.1 | Internationalization |
| `equatable` | ^2.0.7  | Value equality       |

### Development

| Package                | Version | Purpose            |
| ---------------------- | ------- | ------------------ |
| `build_runner`         | ^2.4.6  | Code generation    |
| `injectable_generator` | ^2.4.1  | DI code generation |
| `json_serializable`    | ^6.7.1  | JSON serialization |

---

## Screens

### 1. Home Screen

**Purpose**: Main dashboard with recent transfers

**Features**:

- Welcome header with app branding
- Quick action buttons (Send Money, View All)
- Recent transfers list (sorted by date)
- Empty state for new users
- Error state with retry

---

### 2. Submit Transfer Screen

**Purpose**: Create new wallet transfer

**Features**:

- From/To wallet selection
- Amount input with validation
- Real-time fee calculation (2%)
- Receiver information form
- Optional note field
- Loading state during submission
- Success/error snackbar feedback

---

### 3. Transfer Requests List Screen

**Purpose**: View all transfers with details

**Features**:

- Complete transfer history
- Pull-to-refresh functionality
- Tap to view details
- Empty state for no transfers
- Error state with retry
- Quick add button in AppBar

---

### 4. Request Details Screen

**Purpose**: Detailed view of a specific transfer

**Sections**:

1. **Status Header**

2. **Amount Breakdown Card**

3. **Transfer Route Card**

4. **Receiver Information Card**

---

## Design Patterns & Principles

### SOLID Principles

✅ **Single Responsibility**

- Each widget has one clear purpose
- Utilities handle specific concerns

✅ **Open/Closed Principle**

- Components open for extension
- Closed for modification

✅ **Liskov Substitution**

- Widgets interchangeable where appropriate
- Consistent interfaces

✅ **Interface Segregation**

- Focused widget APIs
- No unnecessary dependencies

✅ **Dependency Inversion**

- Depend on abstractions (repositories)
- Inject dependencies via constructors

### Design Patterns

🔹 **BLoC Pattern** - State management
🔹 **Repository Pattern** - Data access abstraction
🔹 **Dependency Injection** - Loose coupling
🔹 **Factory Pattern** - Object creation
🔹 **Observer Pattern** - State observation (BLoC)

---

## Build & Release

### Development Build

```bash
# Android Debug APK
flutter build apk --debug

# iOS Debug
flutter build ios --debug
```

### Production Build

```bash
# Android Release
flutter build apk --release
# or
flutter build appbundle --release

# iOS Release
flutter build ios --release
```

### Build Configuration

Update version and build number in `pubspec.yaml`:

```yaml
version: 1.0.0+1 # version+build_number
```

---

## Learning Resources

This project demonstrates:

- ✅ Clean Architecture implementation
- ✅ BLoC state management with Freezed
- ✅ Dependency injection with Injectable
- ✅ Widget composition and extraction
- ✅ Form validation and error handling
- ✅ Responsive UI design
- ✅ Code organization and structure

### Recommended Reading

- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Library](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

---
