# 📱 Mini Social Feed Application

A Flutter application designed to simulate a social media feed with features
including media uploads (Camera/Gallery) and video streaming.

![Flutter](https://img.shields.io/badge/Flutter-Latest-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-SDK-blue?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your
local machine for development and testing purposes.

### 1. Prerequisites

Ensure you have the following installed on your system:

* **Flutter SDK** (Latest Stable Channel)
* **Dart SDK**
* **Android Studio** (for Android Emulator) or **Xcode** (for iOS Simulator)

### 2. Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/JafarKMarouf/Mini-Social-Feed-Application.git](https://github.com/JafarKMarouf/Mini-Social-Feed-Application.git)
   cd Mini-Social-Feed-Application
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the application:**
   ```bash
   flutter run
   ```

### 3. Platform Configuration (Important)

Since this app uses Camera, Gallery, and HTTP (non-secure) video URLs, you must
configure native files.

#### Android Setup

Open `android/app/src/main/AndroidManifest.xml`:

1. **Permissions:** Ensure these are present inside `<manifest>`:
   ```xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.CAMERA" />

    <!-- Android 12 and below -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
        android:maxSdkVersion="32" />

    <!-- Android 13+ (Granular Media Permissions) -->
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
    <uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />

   ```

2. **Cleartext Traffic:** Add this to the `<application>` tag to allow video
   streaming from HTTP sources:
   ```xml
   <application
       android:label="mini_social_feed"
       android:usesCleartextTraffic="true" ...>
   ```


### 4. Running the App

```bash
# Run on currently connected device
flutter run

# Run in debug mode (detailed logs)
flutter run -v
```
## 🤝 Contributing

Contributions are welcome!

1. Fork the project.
2. Create your feature branch:
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. Commit your changes:
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. Push to the branch:
   ```bash
   git push origin feature/AmazingFeature
   ```
5. Open a Pull Request.

---

## ⚙️ Configuration

### Dependency Injection

All dependencies are registered in `lib/core/services/service_locator.dart`.

* **Singletons:** Storage services, Router.
* **Factories:** Cubits (BLoCs) are registered as factories to ensure fresh
  state on screen entry.

### Network Configuration

The `DioClient` (`lib/core/network/dio_client.dart`) is pre-configured with:

* **Base URL setup.**
* **Timeouts:** (Connect/Receive).
* **Auth Interceptor:** Automatically injects the Bearer token.
* **Error Interceptor:** Handles token refreshing logic.


## ✨ Key Features

### 🔐 Authentication & Security

* **Secure Auth Flow:** Login, Registration, and Logout.
* **Token Management:** Encrypted storage using `flutter_secure_storage`.
* **Auto-Refresh:** Http Interceptors handle 401/500 errors to automatically
  refresh access tokens without user interruption.
* **Session Management:** Auto-logout upon session expiration.

### 📝 Post Management

* **CRUD Operations:** Create, Read, Update, and Delete posts.
* **Rich Media:** Upload and view Images, Videos, Audio, and Documents.
* **Smart Editing:** `EditPostView` leverages dual-cubit architecture (
  Edit/Show) to pre-fill data efficiently.

### 📱 Feed & Discovery

* **Infinite Scrolling:** Pagination support for smooth browsing.
* **Advanced Search:** Search by content with debounce logic.
* **Filtering:** Filter posts by media type (Photos, Videos, etc.).

### 🌍 UI/UX & Localization

* **Localization (i18n):** Full support for **English** and **Arabic**.
* **Responsive Design:** Adapts to various screen sizes using
  `responsive_sizer`.
* **State Preservation:** `StatefulShellRoute` keeps bottom navigation tabs
  alive.

## 🛠️ Architecture

This project strictly follows **Clean Architecture** principles, dividing the
codebase into three distinct layers:

| Layer            | Responsibility        | Components                                       |
|:-----------------|:----------------------|:-------------------------------------------------|
| **Presentation** | UI & State Management | Widgets, Views, Cubits (BLoC)                    |
| **Domain**       | Business Logic        | Entities, UseCases, Repository Interfaces        |
| **Data**         | Data Access           | Repositories (Impl), Data Sources, Models (DTOs) |

### State Management

We use the **BLoC (Business Logic Component)** pattern via `flutter_bloc` (
specifically **Cubit**).

* **Unidirectional Data Flow.**
* **Equatable States** for efficient rebuilding.
* **Dependency Injection** via `GetIt`.

## 📦 Tech Stack

| Category             | Packages                                                              |
|:---------------------|:----------------------------------------------------------------------|
| **Core**             | `flutter`, `dart`                                                     |
| **State Management** | `flutter_bloc`, `equatable`                                           |
| **DI & Routing**     | `get_it`, `go_router`                                                 |
| **Networking**       | `dio`, `dartz`                                                        |
| **Storage**          | `flutter_secure_storage`, `shared_preferences`                        |
| **Media**            | `image_picker`, `file_picker`, `video_player`, `cached_network_image` |
| **Utilities**        | `intl`, `permission_handler`, `responsive_sizer`                      |

## 📂 Project Structure

```text
lib/
├── core/                   # Core functionality (Network, DI, Utils, Routes)
│   ├── network/            # Dio clients & Interceptors
│   ├── services/           # Service Locator, Storage Services
│   └── utils/              # Constants, Extensions, Resources
├── features/               # Feature-based modules
│   ├── auth/               # Login, Register, Profile
│   ├── posts/              # Feed, Create, Edit, Search
│   ├── profile/            # Manage Account, Settings
│   └── intro/              # Splash screen
└── social_app.dart         # Root Widget (MaterialApp config)

```

---
## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

**Developed by Jafar K Marouf**
