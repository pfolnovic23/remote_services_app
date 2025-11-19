# Hrvatski Rap Microservices App

A Flutter application demonstrating REST API integration with a custom JSON Server backend, showcasing Croatian rap artists and songs with OAuth2 authentication.

## Features

- 🎤 **Reperi Microservice** - Browse Croatian rap artists
- 🎵 **Pjesme Microservice** - Explore Croatian rap songs
- 🔐 **OAuth2 Authentication** - Secure token-based authentication
- 🔄 **Pull-to-Refresh** - Update data on demand
- ⚡ **Real-time Error Handling** - Robust error management
- 🏗️ **Clean Architecture** - Feature-based modular structure

## Project Structure

```
lib/
├── core/
│   ├── network/
│   │   └── api_client.dart         # Dio HTTP client with interceptors
│   └── storage/
│       └── token_storage.dart       # Secure token management
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── auth_models.dart
│   │   │   └── auth_service.dart
│   │   └── presentation/
│   │       ├── login_page.dart
│   │       └── home_page.dart
│   ├── reperi/
│   │   ├── data/
│   │   │   ├── reper_models.dart
│   │   │   └── reper_service.dart
│   │   └── presentation/
│   │       └── reperi_page.dart
│   └── pjesme/
│       ├── data/
│       │   ├── pjesma_models.dart
│       │   └── pjesma_service.dart
│       └── presentation/
│           └── pjesme_page.dart
└── main.dart
```

## Prerequisites

- **Flutter SDK**: 3.10.0 or higher
- **Dart SDK**: 3.0.0 or higher
- **Node.js**: 14.0.0 or higher (for JSON Server)
- **npm**: 6.0.0 or higher

## Setup Instructions

### 1. Install JSON Server

Install JSON Server globally using npm:

```bash
npm install -g json-server
```

Verify installation:

```bash
json-server --version
```

### 2. Clone and Setup Flutter Project

```bash
git clone https://github.com/pfolnovic23/remote_services_app.git
cd remote_services_app
flutter pub get
```

### 3. Generate Model Files

Run build_runner to generate JSON serialization files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Or use watch mode for development:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 4. Start JSON Server

From the project root directory, start the JSON Server:

```bash
json-server --watch db.json --port 3000
```

The API will be available at:
- **Localhost**: `http://localhost:3000`
- **Android Emulator**: `http://10.0.2.2:3000`

You should see:

```
\{^_^}/ hi!

Loading db.json
Done

Resources
http://localhost:3000/reperi
http://localhost:3000/pjesme

Home
http://localhost:3000
```

### 5. Test API Endpoints

#### Test Reperi Endpoint:
```bash
# Get all rappers
curl http://localhost:3000/reperi

# Get single rapper by ID
curl http://localhost:3000/reperi/1
```

#### Test Pjesme Endpoint:
```bash
# Get all songs
curl http://localhost:3000/pjesme

# Get single song by ID
curl http://localhost:3000/pjesme/1
```

### 6. Run Flutter App

#### For Chrome (Web):
```bash
flutter run -d chrome
```

#### For Android Emulator:
```bash
# Start your Android emulator first
flutter emulators --launch <emulator-name>

# Then run the app
flutter run -d emulator-5556
```

#### For Windows Desktop:
```bash
flutter run -d windows
```

## Login Credentials

Use these credentials to login:

- **Email**: `demo@example.com`
- **Password**: `password123`

## API Endpoints

### Reperi (Rappers)

- `GET /reperi` - Fetch all rappers
- `GET /reperi/{id}` - Fetch single rapper by ID

**Sample Response:**
```json
{
  "id": 1,
  "ime": "Vojko V",
  "pravo_ime": "Vojko Vrućina",
  "grupa": "N/A",
  "grad": "Split"
}
```

### Pjesme (Songs)

- `GET /pjesme` - Fetch all songs
- `GET /pjesme/{id}` - Fetch single song by ID

**Sample Response:**
```json
{
  "id": 1,
  "ime": "Struja",
  "grupa": "N/A",
  "trajanje": "3:24",
  "godina": 2019
}
```

## Troubleshooting

### JSON Server Not Found
If you get "command not found" when running `json-server`:

```bash
# Check if npm global bin is in PATH
npm config get prefix

# Add to PATH (Windows PowerShell)
$env:PATH += ";C:\Users\<YourUsername>\AppData\Roaming\npm"

# Or install locally in project
npm install json-server
npx json-server --watch db.json --port 3000
```

### Android Emulator Connection Issues

If the Android emulator can't connect to the API:

1. Make sure JSON Server is running on port 3000
2. The app automatically uses `10.0.2.2:3000` for Android
3. Restart the emulator with DNS settings:

```bash
emulator -avd <avd-name> -dns-server 8.8.8.8,8.8.4.4
```

### Build Runner Errors

If you encounter build_runner errors:

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

## Dependencies

Key packages used in this project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.3.3                      # HTTP client
  flutter_secure_storage: ^9.0.0   # Secure token storage
  json_annotation: ^4.8.1          # JSON serialization
  logger: ^2.0.2                   # Logging

dev_dependencies:
  build_runner: ^2.4.6             # Code generation
  json_serializable: ^6.7.1        # JSON serialization generator
```

## Architecture

This app follows **Clean Architecture** principles with feature-based modules:

- **Data Layer**: Models and API services
- **Presentation Layer**: UI pages and widgets
- **Core Layer**: Shared utilities (network, storage)

## Technologies

- **Flutter & Dart** - Cross-platform UI framework
- **Dio** - HTTP client with interceptors
- **JSON Server** - Mock REST API backend
- **json_serializable** - Type-safe JSON serialization
- **flutter_secure_storage** - Encrypted token storage

## License

This project is created for educational purposes.

---

**Created by**: Pavel Folnović  
**Repository**: [github.com/pfolnovic23/remote_services_app](https://github.com/pfolnovic23/remote_services_app)

