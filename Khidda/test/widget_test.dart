import 'package:flutter_test/flutter_test.dart';
import 'package:khidda/main.dart';
import 'package:khidda/screens/login_screen.dart';

void main() {
  testWidgets('App starts with LoginScreen and contains KHIDDA branding', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KhiddaApp());

    // Verify that the login screen is showing.
    expect(find.byType(LoginScreen), findsOneWidget);
    
    // Verify branding text exists
    expect(find.text('KHIDDA'), findsOneWidget);
    expect(find.text('Taste of Home, Close to Canada'), findsOneWidget);
    
    // Verify login buttons exist
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Don\'t have an account? Sign Up'), findsOneWidget);
  });
}
