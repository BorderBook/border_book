#!/bin/bash

# Install dependencies for Flutter
flutter pub get

# Install dependencies for Node.js
npm install

# Run the Flutter app
flutter run lib/main.dart &

# Run the serverless backend offline
npx serverless offline &

# Wait for all background processes to finish
wait
