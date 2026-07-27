# Implementation Plan - Khidda "Premium Engagement" Update

This plan focuses on enhancing user retention and visual delight through an onboarding experience, parallax animations, and a smart notification hub.

## User Review Required

> [!IMPORTANT]
> **New Dependency**: I will add `shared_preferences: ^2.2.0` to track if the onboarding has been completed.
> **Visual Assets**: For the onboarding screens, I will use high-quality network images related to Bangladeshi food and delivery services.

## Proposed Changes

### Phase 1: Persistence & Onboarding
Ensure new users get a warm welcome and understand the app's value.

#### [MODIFY] [pubspec.yaml](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/pubspec.yaml)
- Add `shared_preferences: ^2.2.0`.

#### [NEW] [onboarding_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/onboarding_screen.dart)
- 3 slides: "Authentic Taste" -> "Fast Delivery" -> "Easy Payment".
- Smooth transition animations using `PageView`.
- "Get Started" button that saves the completion state.

#### [MODIFY] [main.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/main.dart)
- Update `main()` to initialize `SharedPreferences` and pass the `showOnboarding` flag to the app root.

---

### Phase 2: Visual Delight (Parallax)
Make the scrolling experience feel deep and high-end.

#### [MODIFY] [dish_card.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/widgets/dish_card.dart)
- Implement a parallax effect on the dish images. As the user scrolls the list, the image moves slightly within its frame at a different speed.

---

### Phase 3: Smart Notification Center
A dedicated hub for promotions, order updates, and system alerts.

#### [NEW] [notification_provider.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/providers/notification_provider.dart)
- Manage a list of `NotificationModel` items.
- Support "Mark as read" and "Clear all" logic.

#### [NEW] [notification_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/notification_screen.dart)
- A clean, categorized list of messages.
- Different icons for "Promotion", "Order", and "System" alerts.

#### [MODIFY] [home_screen.dart](file:///C:/Users/fuadk/Documents/GitHub/Khidda/Khidda/lib/screens/home_screen.dart)
- Add a Bell icon to the AppBar with a dynamic badge (e.g. "3") showing unread counts.

## Verification Plan

### Automated Tests
- Test `NotificationProvider` for correct unread count logic.
- Verify that `Main` chooses the correct starting screen based on the preference flag.

### Manual Verification
1. **Fresh Launch**: Uninstall/Reset app and verify the Onboarding slides appear.
2. **Scrolling**: Scroll the home menu and observe the "floating" movement of images inside the cards (Parallax).
3. **Notifications**: Open the Notification screen, mark an item as read, and verify the badge on the Home screen updates.
4. **Theme**: Verify that the new screens (Onboarding/Notifications) support both Light and Dark modes.
