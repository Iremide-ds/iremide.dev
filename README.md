# IREMIDE.DEV — Flutter Web Portfolio

A pixel-perfect Flutter web implementation of the IREMIDE.DEV portfolio design.

## Tech Stack

- **Flutter** ≥ 3.10 / **Dart** ≥ 3.0
- `google_fonts` — JetBrains Mono + Space Grotesk
- `flutter_animate` — entry animations
- `visibility_detector` — scroll-triggered reveals
- `url_launcher` — social/CTA links

## Project Structure

```
lib/
├── main.dart               # App entry + theme
├── app_colors.dart         # Design token colors
├── portfolio_page.dart     # Root page + scroll nav
├── sections/
│   ├── navbar.dart
│   ├── hero_section.dart
│   ├── tech_stack_section.dart
│   ├── selected_works_section.dart
│   ├── contact_section.dart
│   └── footer_section.dart
└── widgets/
    ├── tag_chip.dart
    └── section_label.dart
web/
└── index.html              # Flutter web entry
```

## Setup & Run

```bash
# 1. Get dependencies
flutter pub get

# 2. Run on web (Chrome)
flutter run -d chrome

# 3. Build for production
flutter build web --release

# Serve the build:
cd build/web && python3 -m http.server 8080
```

## Features

- ✅ Responsive layout (mobile / desktop breakpoints)
- ✅ Smooth scroll-to-section navigation
- ✅ Animated hero entry (staggered with flutter_animate)
- ✅ Blinking terminal cursor in hero card
- ✅ Hover micro-interactions on all interactive elements
- ✅ Subtle grid background via CustomPainter
- ✅ Contact form with loading + success states
- ✅ Accent-colored project cards (blue / green / purple)
- ✅ JetBrains Mono monospace + Space Grotesk display fonts

## Customisation

- Replace placeholder social links in `hero_section.dart`
- Swap project data in `selected_works_section.dart` → `_projects`
- Adjust `AppColors` in `app_colors.dart` for theming
