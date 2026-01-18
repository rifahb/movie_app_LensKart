# Flutter Movie App 🎬

A beautiful, functional movie discovery application built with Flutter. Browse trending movies, search for your favorites, and save them to your personal Watchlist or Favorites collection.

## ✨ Features

- **Home Feed**: Browse trending movies (Weekly).
- **Search**: Find any movie by title.
- **Detailed View**: High-quality posters, backdrops, ratings (circular indicator), release dates, and overviews.
- **Local Persistence**: 
  - **Favorites**: Save movies you love.
  - **Watchlist**: Save movies you want to see later.
  - *Data is saved locally on your device.*
- **Responsive Design**: Works on Android, iOS, Web, and Windows.
- **Clean Architecture**: Built using MVVM pattern with `Provider` for state management.

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
- A free API Key from [TMDB](https://www.themoviedb.org/).

### 🛠️ Installation & Setup

1.  **Clone the repository** (or unzip the project):
    ```bash
    git clone https://github.com/yourusername/movie_app.git
    cd movie_app
    ```

2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **🔑 Configure API Key**:
    *   Open `lib/core/constants.dart`.
    *   Find the `apiKey` constant.
    *   Replace `'YOUR_API_KEY_HERE'` with your actual TMDB API Key.
    ```dart
    static const String apiKey = 'your_actual_api_key_here';
    ```

4.  **Run the App**:
    *   **Windows**:
        *   *Note: Ensure "Developer Mode" is enabled in Windows Settings.*
        ```bash
        flutter run -d windows
        ```
    *   **Chrome (Web)**:
        ```bash
        flutter run -d chrome
        ```
    *   **Mobile (Android/iOS)**:
        *   Connect your device or start an emulator.
        ```bash
        flutter run
        ```

5.  **Build for Release**:
    *   **Windows**:
        ```bash
        flutter build windows
        ```
    *   **Web**:
        ```bash
        flutter build web
        ```
    *   **Android (APK)**:
        ```bash
        flutter build apk
        ```

6.  **Run Tests**:
    ```bash
    flutter test
    ```

## 🏗️ Project Structure

```
lib/
├── core/            # Constants & Utilities
├── data/
│   ├── models/      # Data Models (Movie)
│   └── services/    # API & Storage Services
├── presentation/
│   ├── providers/   # State Management (MVVM)
│   ├── screens/     # UI Screens (Home, Details, etc.)
│   └── widgets/     # Reusable Widgets (MovieCard)
└── main.dart        # Entry Point
```

## 📦 Dependencies

- [provider](https://pub.dev/packages/provider): State Management.
- [http](https://pub.dev/packages/http): API requests.
- [cached_network_image](https://pub.dev/packages/cached_network_image): Image caching.
- [shared_preferences](https://pub.dev/packages/shared_preferences): Local storage.
- [percent_indicator](https://pub.dev/packages/percent_indicator): Circular rating rings.

## 🤝 Contributing

This is a personal educational project. Feel free to fork and experiment!
