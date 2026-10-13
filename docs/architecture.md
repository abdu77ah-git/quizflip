# QuizFlip Architecture

## Flutter Version

- SDK constraint: `^3.9.0`

## Pattern

- MVVM + Repository + DataSource
- UI calls ViewModel only
- ViewModel depends on repository interface, not concrete data source

## Provider Configuration

- `MultiProvider` in app root
- `ChangeNotifierProvider` for `FlashcardViewModel`

## Dependency Injection

- Centralized in `lib/core/di/dependency_injection.dart`
- Single responsibility for object graph creation

## Routing Strategy

- Named routes only
- Central route constants and route generator
- Navigation helper for decoupled navigation calls

## Theme Strategy

- Separate light and dark themes
- Shared color and typography tokens

## Coding Standards

- Enforce lint rules from `flutter_lints`
- Keep widgets stateless where possible
- Keep ViewModels UI-agnostic
- Prefer immutable models

## SOLID Alignment

- Single Responsibility: each layer has one responsibility
- Open/Closed: repositories and data sources are interface-driven
- Liskov Substitution: implementations substitute interfaces cleanly
- Interface Segregation: focused contracts (`FlashcardRepository`, `FlashcardDataSource`)
- Dependency Inversion: ViewModel depends on abstractions

## Folder Hierarchy

- `lib/app`: app bootstrap and root app widget
- `lib/core`: shared constants, theme, helpers, errors, DI
- `lib/domain`: models and repository contracts
- `lib/data`: datasource and repository implementations
- `lib/presentation`: viewmodels, views, reusable widgets
- `lib/routing`: route constants, route generator, navigation service
- `test`: unit, repository, viewmodel, widget tests
