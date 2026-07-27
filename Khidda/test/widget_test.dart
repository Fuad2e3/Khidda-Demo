import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khidda/main.dart';
import 'package:khidda/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:khidda/providers/cart_provider.dart';
import 'package:khidda/providers/user_provider.dart';
import 'package:khidda/providers/wishlist_provider.dart';
import 'package:khidda/providers/settings_provider.dart';
import 'package:khidda/providers/notification_provider.dart';

void main() {
  testWidgets('App starts with LoginScreen and contains KHIDDA branding', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => WishlistProvider()),
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ],
        child: const KhiddaApp(showOnboarding: false),
      ),
    );
    
    await tester.pumpAndSettle();

    // Verify that the login screen is showing.
    expect(find.byType(LoginScreen), findsOneWidget);
    
    // Verify branding text exists
    expect(find.text('KHIDDA'), findsOneWidget);
  });
}
