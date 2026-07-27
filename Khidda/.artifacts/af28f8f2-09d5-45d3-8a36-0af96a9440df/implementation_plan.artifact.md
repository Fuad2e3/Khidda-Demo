# Implementation Plan - Completing Khidda App Functionality

The Khidda app currently has a solid UI structure but many core functions are either missing, mocked, or incomplete. This plan aims to bridge those gaps to make the app fully functional.

## User Review Required

> [!IMPORTANT]
> **Firebase Configuration**: The app refers to Firebase but the initialization is commented out. I will enable it, but it requires `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to be present in the respective directories to work in a real environment.
> **Backend API**: The `ApiService` points to `localhost:3000`. I will implement error handling so the app gracefully falls back to mock data if the backend is unreachable.
> **State Management**: I will introduce the `provider` package for simple and effective state management (specifically for the shopping cart).

## Proposed Changes

### Core Infrastructure

#### [MODIFY] [pubspec.yaml](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/pubspec.yaml)
- Add `provider` dependency for state management.
- Ensure `firebase_core` and `firebase_auth` are correctly included.

#### [MODIFY] [main.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/main.dart)
- Initialize Firebase properly.
- Wrap `MaterialApp` with a `MultiProvider` to provide the `CartProvider` and `AuthProvider` to the entire app.

### Authentication

#### [NEW] [signup_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/signup_screen.dart)
- Implement a screen for new users to register.

#### [MODIFY] [login_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/login_screen.dart)
- Integrate `AuthService` for real login.
- Add navigation to the `SignUpScreen`.

### State Management & Cart

#### [NEW] [cart_provider.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/providers/cart_provider.dart)
- Create a provider to manage cart items, totals, and clearing the cart.

#### [MODIFY] [dish_card.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/widgets/dish_card.dart)
- Add an "Add to Cart" button or icon.

### Screen Enhancements

#### [MODIFY] [home_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/home_screen.dart)
- Fetch dishes from `ApiService`.
- Show a loading indicator while fetching.
- Implement "Add to Cart" logic.

#### [MODIFY] [checkout_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/checkout_screen.dart)
- Display dynamic cart items instead of hardcoded ones.
- Calculate totals based on the cart state.
- Integrate `PaymentService` (mocked) during the "Place Order" process.

### Testing

#### [MODIFY] [widget_test.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/test/widget_test.dart)
- Fix the broken smoke test to work with `KhiddaApp`.

## Verification Plan

### Automated Tests
- Run `flutter test` to verify the fixed smoke test.

### Manual Verification
1. **Login Flow**: Verify that the login screen attempts to use Firebase (or shows an error if not configured).
2. **Cart Flow**: Add multiple items to the cart on `HomeScreen` and verify they appear on `CheckoutScreen`.
3. **Checkout Flow**: Verify total calculation and navigation to `OrderTrackingScreen`.
4. **Order Tracking**: Step through the demo stages and verify navigation to `FeedbackScreen`.
5. **Feedback**: Submit feedback and verify navigation back to Home.
