# Movie App

This repository contains a Flutter application for browsing and exploring movies.

### Prerequisites

Before you begin, ensure you have met the following requirements:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
- [Flutter Version Manager (FVM)](https://fvm.app/) installed for managing Flutter versions.
- Clone this repository to your local machine.

### Installation

Follow these steps to set up and run the project:

1. Clone the repository:

   ```sh
   git clone <repository_url>
   ```

2. Navigate to the project directory:

   ```sh
   cd movie
   ```

3. Install Flutter using FVM (if not installed):

   ```sh
   fvm install
   ```

4. Select the Flutter version for this project:

   ```sh
   fvm use
   ```

5. Install dependencies:

   ```sh
   flutter pub get
   ```

### Configuration

**Downloading the .env File:**

Before running the app, make sure to download the `.env` file and place it in the root directory of the project. This file contains sensitive information such as API keys and should not be shared publicly.

### Generating Files

Before running the app, generate necessary files:

```sh
dart run build_runner build --delete-conflicting-outputs
```

### Running the App

Now you can run the app on your preferred device (emulator/simulator or physical device):

```sh
flutter run
```

## Dependencies

This project relies on several third-party packages to enhance its functionality:

- **intl:** For localization purposes.
- **flutter_svg:** For rendering SVG images.
- **infinite_carousel:** For creating carousel views.
- **cached_network_image:** For caching network images.
- **youtube_player_flutter:** For playing YouTube videos within the app.
- **flutter_gen:** For managing app resources and generating code.
- **envied:** For managing environment variables.
- **bloc** and **flutter_bloc:** For state management using the BLoC pattern.
- **get_it** and **injectable:** For dependency injection.
- **flutter_secure_storage:** For secure local storage.
- **dio:** For making network requests.
- **freezed:** For generating immutable classes.
- **go_router:** For routing within the app.
- **dartz** and **logger:** For functional programming and logging.
- **nested:** For nested routing.

## Acknowledgments

- [Flutter Documentation](https://flutter.dev/docs)
- [Flutter Gen](https://pub.dev/packages/flutter_gen)
- [TMDB API](https://www.themoviedb.org/documentation/api)
