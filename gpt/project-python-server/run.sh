#!/bin/bash

# Install Flutter dependencies
flutter pub get

# Install Python dependencies
pip install -r lambda_functions/requirements.txt --target lambda_functions/

# Run the Flutter app
flutter run lib/main.dart
