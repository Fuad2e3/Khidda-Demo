# Implementation Plan - Premium Design Refinement

This plan focuses on a complete visual overhaul of the Khidda app to give it a modern, high-end "Silicon Valley" aesthetic while retaining its Bangladeshi heritage.

## User Review Required

> [!IMPORTANT]
> **Google Fonts**: I will add `google_fonts: ^6.2.1` to provide professional typography (Poppins).
> **UI Overhaul**: This will change the look of buttons, cards, and input fields globally.

## Proposed Changes

### 1. Typography & Global Theme

#### [MODIFY] [pubspec.yaml](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/pubspec.yaml)
- Add `google_fonts: ^6.2.1`.

#### [MODIFY] [main.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/main.dart)
- Update `ThemeData` to use `GoogleFonts.poppinsTextTheme()`.
- Refine `ColorScheme` for better contrast and vibrancy.

---

### 2. Modernized Components

#### [MODIFY] [custom_button.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/widgets/custom_button.dart)
- Add subtle gradients.
- Improve elevation and splash effects.

#### [MODIFY] [dish_card.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/widgets/dish_card.dart)
- Implement softer shadows (`blurRadius: 20`).
- Improve internal padding and text hierarchy.

---

### 3. Screen Polish

#### [MODIFY] [home_widgets.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/widgets/home_widgets.dart)
- **CategorySelector**: Modernize the pills with glassmorphism-inspired effects.
- **PromoSlider**: Enhance text overlays with better typography and "Shop Now" micro-buttons.

#### [MODIFY] [login_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/login_screen.dart) & [signup_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/signup_screen.dart)
- Use a soft background gradient.
- Modernize input fields with subtle borders and icons.

---

### 4. Navigation Refinement

#### [MODIFY] [main_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/main_screen.dart)
- Polish the `BottomNavigationBar` with better active/inactive contrast and subtle scaling animations.

## Verification Plan

### Manual Verification
1. **Typography Check**: Ensure Poppins is applied consistently across all screens.
2. **Contrast Check**: Verify that text is easily readable on both Light and Dark modes.
3. **Card Aesthetics**: Scroll through the home screen and ensure the new dish cards feel "Premium".
4. **Login Experience**: Test the new login flow and ensure it feels welcoming.
