# QuizFlip

QuizFlip is an offline flashcard study app built with Flutter. Create question-and-answer cards, flip to reveal answers, and navigate through your deck — all stored locally on your device.

## Features

- Show question and reveal answer with a flip animation
- Navigate flashcards with Next and Previous
- Add, edit, and delete flashcards
- Local persistence (SQLite on mobile/desktop, localStorage on web)
- Light and dark themes (follows system setting)
- Runs on Android, iOS, Web, Windows, macOS, and Linux

## Architecture

The app follows **MVVM** with a **Repository** and **DataSource** pattern:

```
lib/
  app/           → bootstrap and root MaterialApp
  core/          → constants, DI, theme, errors, helpers
  domain/        → models and repository contracts
  data/          → SQLite / web storage implementations
  presentation/  → viewmodels, views, widgets
  routing/       → named routes and navigation
```

- **ViewModels** hold state and business logic; widgets stay UI-only.
- **Repositories** abstract data access; ViewModels never touch the database directly.
- **Strings and colors** live in `lib/core/constants/` (`app_strings.dart`, `app_colors.dart`).

See [docs/architecture.md](docs/architecture.md) for full details.

## Packages

| Package | Purpose |
|---------|---------|
| `provider` | State management (`ChangeNotifier`) |
| `sqflite` | SQLite persistence on mobile/desktop |
| `path` | Database file paths |
| `equatable` | Value equality for models |
| `flutter_launcher_icons` | App icon generation (dev) |
| `flutter_native_splash` | Splash screen generation (dev) |
| `flutter_lints` | Static analysis rules (dev) |
| `mocktail` | Test mocking (dev) |

## Requirements

- Flutter SDK compatible with Dart `^3.9.0`
- For Android release builds: JDK 11+
- For iOS/macOS builds: Xcode (macOS only)

## Getting Started

```bash
# Install dependencies
flutter pub get

# Generate app icons and splash screen (after updating assets/images/QuizFlip.png)
dart run flutter_launcher_icons
dart run flutter_native_splash:create

# Run on a connected device or emulator
flutter run

# Run on a specific platform
flutter run -d chrome      # Web
flutter run -d windows       # Windows
flutter run -d macos         # macOS
flutter run -d linux         # Linux
```

## Testing

```bash
flutter analyze
flutter test
```

## Release Builds

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS (requires macOS + Xcode)
flutter build ios --release

# Desktop & Web
flutter build windows --release
flutter build macos --release
flutter build linux --release
flutter build web --release
```

## App Identity

| Setting | Value |
|---------|-------|
| Display name | QuizFlip |
| Package ID | `com.quizflip.app` |
| Min Android SDK | 21 |
| App icon | `assets/images/QuizFlip.png` |

## Project Structure

```
assets/images/     → app logo source image
android/           → Android platform config
ios/               → iOS platform config
web/               → Web platform config
windows/           → Windows platform config
macos/             → macOS platform config
linux/             → Linux platform config
test/              → unit and widget tests
docs/              → architecture documentation
```

## License

Private project — not published to pub.dev.
