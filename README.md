# Auth Generator

Auth Generator is a Flutter application that generates SOAP authentication headers. The application creates an authentication header by encrypting a user's password and creating a digest using AES and RSA encryption. It features a simple, Fluent UI interface for entering a username, password, and environment setting.

## Features

- Generate SOAP authentication headers with encrypted password and nonce.
- Supports AES encryption for secure communication.
- Uses RSA public key encryption to secure the symmetric key.
- User-friendly interface built with Fluent UI.
- State management using Provider.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A compatible IDE (e.g., Android Studio)

### Installation

1. Clone the repository.

2. Navigate to the project directory:
   ```bash
   cd auth_generator
   ```

3. Get the required packages:
   ```bash
   flutter pub get
   ```

### Running the App

To run the app as a macOS, Windows, or Linux application, use the following command:

```bash
flutter run --platform macos/windows/linux
```

## Project Structure

- **lib/main.dart**: Application entry point that initializes the service locator, loads keys, and runs the app.
- **lib/views/home_view.dart**: Contains the main navigation structure and integrates the Generator and Settings views.
- **lib/views/generator_view.dart**: Provides the UI for entering the username, password, and environment, as well as displaying the generated header.
- **lib/view_models/generator_view_model.dart**: Handles the business logic for generating the authentication header.
- **lib/services/api_authentication_service.dart**: Implements the API authentication header generation logic including encryption.
- **lib/constants/xml_constants.dart**: Defines the SOAP XML constants used in the header.