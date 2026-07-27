# Implementation Plan - Khidda "Full House" Production Update

This ambitious plan will integrate ALL remaining professional features discussed to make Khidda a complete, production-ready platform.

## User Review Required

> [!WARNING]
> **Firebase & APIs**: Real features like Push Notifications, Live Tracking (Google Maps), and Real Stripe Payments require active server-side logic and valid API keys. I will implement the **App-side logic and UI**, but they will function in "Simulation Mode" until you provide real keys.
> **Complexity**: This update involves a major overhaul of almost every screen and the introduction of new state providers.

## Proposed Changes

### Phase 1: Personalization (Bangla & Dark Mode)
Making the app accessible and modern.

#### [MODIFY] [main.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/main.dart)
- Set up `localizationsDelegates` for English and Bangla.
- Add `darkTheme` configuration.
- Introduce `SettingsProvider` to toggle language and theme globally.

#### [NEW] [l10n.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/utils/l10n.dart)
- Create a simple translation map for core strings (Home, Order, Profile, etc.).

---

### Phase 2: Order Customization & Address Book
Improving the ordering flow.

#### [MODIFY] [dish_detail_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/dish_detail_screen.dart)
- Add "Customization" section (Checkboxes for Extra Rice, Spicy Level radio buttons).
- Pass these choices into the `CartProvider`.

#### [NEW] [address_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/address_screen.dart)
- Screen to manage "Home", "Office", and "Other" addresses.

---

### Phase 3: Financials (Real Stripe & Wallet)

#### [MODIFY] [payment_service.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/services/payment_service.dart)
- Implement actual `Stripe.instance.presentPaymentSheet()` logic.

#### [NEW] [wallet_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/wallet_screen.dart)
- A screen to show balance, transaction history, and "Add Money" button.

---

### Phase 4: Real-time Tracking & Reviews

#### [MODIFY] [order_tracking_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/order_tracking_screen.dart)
- Integrate `GoogleMap` widget to show rider position (simulated movement).

#### [NEW] [review_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/review_screen.dart)
- Add stars and text field for reviews.
- Integrate Image Picker (simulated) for food photos.

---

### Phase 5: Admin & Notifications

#### [NEW] [admin_dashboard.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/admin_dashboard.dart)
- A basic dashboard to view incoming orders and toggle dish availability.

## Verification Plan

### Automated Tests
- Extend widget tests to verify language switching.
- Verify that customization data correctly reaches the checkout summary.

### Manual Verification
1. **Language**: Toggle to Bangla in Settings and verify the Home tab label changes.
2. **Customization**: Add "Extra Spicy" Biryani and check if it shows in the Cart.
3. **Map**: Open tracking and see a marker representing the rider on a Toronto/Dhaka map.
4. **Theme**: Switch to Dark Mode and ensure all text remains readable.
