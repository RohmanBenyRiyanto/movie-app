#!/bin/bash
printf "\nBefore proceeding, ensure you have the signing key named 'keystore.jks' placed in the 'android/app' folder. "
read -p "Press Enter to continue..." -r

read -p "Enter the flavor name: " FLAVOR_NAME
read -p "Enter the build number: " BUILD_NUMBER
read -p "Enter the keystore password: " KEYSTORE_PASSWORD
read -p "Enter the key password: " KEY_PASSWORD
read -p "Enter the alias: " KEYSTORE_ALIAS

# Get main Flutter package
FLUTTER_ROOT_PACKAGE="$(./get_main_package)"
cd "$FLUTTER_ROOT_PACKAGE" || exit 1

# Build the Flutter APK
flutter build apk --release \
    --flavor "${FLAVOR_NAME}" \
    --build-number "${BUILD_NUMBER}" \
    -Psigning \
    -PkeyStore=keystore.jks \
    -PkeyStorePassword="${KEYSTORE_PASSWORD}" \
    -PkeyPass="${KEY_PASSWORD}" \
    -Palias="${KEYSTORE_ALIAS}"

read -p "Do you want to continue with Firebase upload? (y/n, default: y): " -n 1 -r
echo

if ! [[ ! $REPLY =~ ^[Nn]$ ]]; then
    echo "Firebase upload aborted. Exiting..."
    exit 0
fi

if ! command -v firebase &> /dev/null; then
    echo -e "Firebase tools not found. Installing..."
    curl -sL https://firebase.tools | bash
else
    echo -e "Firebase tools already installed."
fi

echo -e "Firebase app id is generated in firebase when setting up android firebase project setup"
read -p "Enter your Firebase project's app ID: " APP_ID

printf "
To get a Firebase token, install the Firebase CLI from https://firebase.google.com/docs/cli
and run the following command in a console or terminal: firebase login:ci
You will be prompted to log in with a Firebase account.
Choose the correct Firebase account, and once logged in, you will find a token in the console.
"

read -p "Enter your Firebase authentication token: " FIREBASE_TOKEN

# Publish to Firebase for testing
firebase appdistribution:distribute "build/app/outputs/flutter-apk/app-${FLAVOR_NAME}-release.apk" \
--app "${APP_ID}" \
--token "${FIREBASE_TOKEN}" \
--groups "testers" \
--release-notes "Build ${BUILD_NUMBER}"