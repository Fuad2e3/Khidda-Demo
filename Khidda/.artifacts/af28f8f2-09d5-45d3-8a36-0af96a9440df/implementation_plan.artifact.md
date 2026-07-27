# Implementation Plan - Khidda App Mega Update

This plan covers the implementation of several major design and functional updates to the Khidda app to make it a world-class food delivery platform.

## User Review Required

> [!IMPORTANT]
> **New Dependencies**: I will add `carousel_slider` for promotional banners and `flutter_localizations` for Bangla language support.
> **Complex Logic**: Real-time map tracking requires a Google Maps API key. I will implement the UI for tracking, but live rider movement depends on a backend and API key.
> **State Management**: I will expand the `MultiProvider` to handle User Profiles and Wishlists.

## Proposed Changes

### Phase 1: Home Screen Re-design & Enhancements
Focus on making the main landing page more attractive and functional.

#### [MODIFY] [pubspec.yaml](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/pubspec.yaml)
- Add `carousel_slider: ^5.0.0`
- Add `flutter_localizations` under dependencies.

#### [NEW] [home_widgets.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/widgets/home_widgets.dart)
- `CategorySelector`: A horizontal scrolling list of food categories.
- `PromoSlider`: A carousel for discount banners.
- `SearchBar`: A functional search input for dishes.

#### [MODIFY] [home_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/home_screen.dart)
- Integrate the new widgets into a `CustomScrollView` or a `ListView`.
- Implement category filtering logic.

---

### Phase 2: User Profile & Personalization
Allow users to manage their identity and see their history.

#### [NEW] [user_provider.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/providers/user_provider.dart)
- Manage user profile data (name, email, saved addresses).

#### [NEW] [profile_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/profile_screen.dart)
- Display user details and navigation to History/Favorites.

#### [NEW] [order_history_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/order_history_screen.dart)
- List previous orders with "Re-order" functionality.

---

### Phase 3: Advanced Features
Adding "Wishlist" and "Promo Code" systems.

#### [NEW] [wishlist_provider.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/providers/wishlist_provider.dart)
- Manage a list of favorite dishes.

#### [MODIFY] [dish_card.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/widgets/dish_card.dart)
- Add a "Heart" icon to toggle favorites.

#### [MODIFY] [checkout_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/checkout_screen.dart)
- Add a Promo Code input field and discount logic.

---

### Phase 4: Branding & Localization
Final polish with Dark Mode and Bangla support.

#### [MODIFY] [main.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/main.dart)
- Configure `darkTheme`.
- Set up `localizationsDelegates` and `supportedLocales` (English & Bengali).

## Verification Plan

### Automated Tests
- Run existing widget tests to ensure no regressions.
- Add a new test for category filtering.

### Manual Verification
1. **Home UI**: Check if the Carousel and Categories look good.
2. **Filtering**: Tap 'Biryani' and verify only biryani dishes show up.
3. **Wishlist**: Add an item to favorites and check if it persists.
4. **Localization**: Switch phone language to Bangla and check if UI strings update (where implemented).
