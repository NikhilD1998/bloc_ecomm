# bloc_ecomm

A Flutter BLoC-based e-commerce demo app.

## Project Overview

bloc_ecomm is a sample e-commerce mobile application built with Flutter and BLoC for state management. It features:

- Product listing, details, and sorting/filtering
- Cart management with real-time updates and Hive persistence
- Multi-step checkout flow (cart review, shipping, order summary)
- Authentication with guest mode and login (mocked)
- Order history for logged-in users
- Responsive UI with custom theming and dark mode support

## Setup Instructions

1. **Clone the repository:**

   ```
   git clone <your-repo-url>
   cd bloc_ecomm
   ```

2. **Install dependencies:**

   ```
   flutter pub get
   ```

3. **Generate Hive TypeAdapters (if needed):**

   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

   or

   ```
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app:**
   ```
   flutter run
   ```

## Requirements

- **Flutter:** 3.32.8 (channel stable)
- **Dart:** 3.8.1
