# AGENTS.md

## Project

Flutter personal-finance app (auth, bills, goals, subscriptions, balances).  
State: `flutter_riverpod` + `riverpod`. HTTP: `dio`. Local storage: `shared_preferences`.  
Payments: `purchases_flutter` (RevenueCat). Font: Lora (weight 600).

## Entrypoint

`lib/main.dart` → `ProviderScope` → `ScreenUtilInit` → `MaterialApp` with named route generation.

## Commands

| Action | Command |
|---|---|
| Get dependencies | `flutter pub get` |
| Static analysis | `flutter analyze` |
| Format | `dart format .` |
| Run tests | `flutter test` |
| Run app | `flutter run` |
| Build (any platform) | `flutter build <platform>` |

No build_runner, no code generation, no CI.

## Architecture

- `lib/core/` — network (Dio client, hardcoded base URL `http://192.168.7.42:4222`), constants (colors, fonts, strings, values, icons, images), route manager, services (RevenueCat)
- `lib/data/models/` — JSON-serializable models with `fromJson`/`toJson`
- `lib/data/repositories/` — data layer
- `lib/data/sources/remote/` — HTTP calls per domain
- `lib/data/sources/local/` — SharedPreferences wrapper (token, role, email)
- `lib/presentation/` — feature folders, each with `view/` and optionally `viewmodel/`
- `lib/presentation/provider/` — Riverpod providers (user, subscription, setup data)
- `lib/presentation/widgets/` — shared custom widgets

## Route flow

`"/"` (SplashScreen) → `"/onBoardingRoute"` → `"/signIn"` or `"/signUpRoute"` → `"/bottomNav"`

Routes defined in `RouteGenerator.getRoute` (`lib/core/route/route_manager.dart`).

## Conventions

- Design size: 375×812 (`ScreenUtilInit`)
- `flutter_lints: ^6.0.0` with default `package:flutter_lints/flutter.yaml` — no custom overrides
- RevenueCat secret key (`sk_...`) hardcoded in `lib/core/services/revenuecat_service.dart`
- API keys and environment config are hardcoded in source files (no `.env`)
- Colors in `lib/core/resource/constants/color_manger.dart` (gold/brown/cream palette)
- Only one test file exists (`test/widget_test.dart`, default template)
