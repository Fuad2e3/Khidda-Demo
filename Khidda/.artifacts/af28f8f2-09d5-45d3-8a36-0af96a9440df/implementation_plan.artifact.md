# Implementation Plan - Khidda Ultimate Experience Update

This plan transforms the Khidda app into a high-end, premium food delivery platform by adding advanced UI components, animations, and essential user flows.

## User Review Required

> [!IMPORTANT]
> **New Dependencies**: I will add `shimmer` for skeleton loading effects and `lottie` for advanced animations.
> **Navigation Change**: The app's entry point after login will change from `HomeScreen` to a new `MainScreen` which contains the Bottom Navigation Bar.
> **Assets**: Lottie animations usually require `.json` files. I will use network URLs for Lottie files to avoid requiring manual asset additions from the user for now.

## Proposed Changes

### Phase 1: Navigation & Structure
Establish a modern navigation pattern.

#### [MODIFY] [pubspec.yaml](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/pubspec.yaml)
- Add `shimmer: ^3.0.0`
- Add `lottie: ^3.1.2`

#### [NEW] [main_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/main_screen.dart)
- Implement `BottomNavigationBar` with 4 tabs: Home, Wishlist, Cart (or Explore), Profile.
- Manage navigation state across these tabs.

#### [MODIFY] [login_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/login_screen.dart)
- Update navigation to push `MainScreen` instead of `HomeScreen`.

---

### Phase 2: Premium UI Components
Adding "Polish" to the user experience.

#### [NEW] [shimmer_widgets.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/widgets/shimmer_widgets.dart)
- Create `DishCardShimmer`: A skeleton loader that matches the `DishCard` layout.

#### [MODIFY] [home_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/home_screen.dart)
- Replace the simple `CircularProgressIndicator` with the new `DishCardShimmer`.
- Remove the leading Profile icon from AppBar (since it's now in BottomNav).

---

### Phase 3: New Essential Screens
Expanding the app's functionality.

#### [NEW] [dish_detail_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/dish_detail_screen.dart)
- Large image header.
- Detailed description, rating, and price.
- "Add to Cart" and "Favorite" toggles.
- Quantity selector.

#### [NEW] [wishlist_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/wishlist_screen.dart)
- Display all items the user has favorited.
- Quick "Add to Cart" from the list.

---

### Phase 4: Feedback & Delighters
Making the app feel alive.

#### [NEW] [order_success_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/order_success_screen.dart)
- Use a Lottie animation (celebration/success).
- Display order summary and navigation to tracking.

#### [MODIFY] [checkout_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/checkout_screen.dart)
- Update navigation to `OrderSuccessScreen` upon successful payment.

## Verification Plan

### Automated Tests
- Run existing tests to ensure no core logic is broken by navigation changes.

### Manual Verification
1. **Navigation**: Verify BottomNav switches correctly between Home, Wishlist, and Profile.
2. **Shimmer**: Force a slow network/loading state to see the skeleton loader in action.
3. **Details**: Tap a dish on Home and verify `DishDetailScreen` opens with correct data.
4. **Success Flow**: Place an order and verify the Lottie celebration appears.
