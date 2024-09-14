#!/bin/bash

# Install Node.js dependencies
npm install

# Install Flutter dependencies
flutter pub get

# Run the serverless offline and Flutter app in parallel
npx serverless offline & flutter run
