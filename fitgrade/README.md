# FitGrade — AI Outfit Rating App

## Setup Instructions

### 1. Flutter Setup
```bash
flutter pub get
```

### 2. Supabase Database
- Go to your Supabase project dashboard
- Open SQL Editor
- Run the contents of `supabase_setup.sql`

### 3. iOS Setup
```bash
# Copy Podfile to ios/ folder, then:
cd ios && pod install && cd ..
flutter run
```

### 4. Credentials
- Supabase URL: https://hnkoxzengyqprongevee.supabase.co
- Anon key: already set in lib/main.dart

## Project Structure
```
lib/
├── main.dart                    # App entry + Supabase init + AuthGate
├── theme.dart                   # AppColors (light/dark)
├── theme_controller.dart        # Dark mode singleton
├── widgets/common.dart          # Shared UI components
├── services/
│   ├── auth_service.dart        # Supabase Auth
│   └── fitcheck_service.dart    # Outfit checks CRUD
└── screens/ (18 screens)
    ├── splash_screen.dart
    ├── onboarding_screen.dart
    ├── signup_screen.dart
    ├── login_screen.dart
    ├── main_shell.dart
    ├── home_screen.dart
    ├── check_screen.dart
    ├── analyzing_screen.dart
    ├── result_screen.dart
    ├── history_screen.dart
    ├── profile_screen.dart
    ├── settings_screen.dart
    └── ... (6 more)
```

## Tech Stack
- Flutter/Dart 2.19.6
- Supabase (Auth + Postgres)
- Google Sign-In
- Google Fonts (DM Sans)

## What's Next
- Phase 3: AI outfit analysis (GPT-4o Vision)
- Phase 4: Photo storage
- Phase 5: Push notifications
- Phase 6: Pro paywall (RevenueCat)
