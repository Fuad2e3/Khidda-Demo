import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/cart_provider.dart';
import 'providers/user_provider.dart';
import 'providers/wishlist_provider.dart';
import 'providers/settings_provider.dart';
import 'utils/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (Requires google-services.json/GoogleService-Info.plist)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // On Web, it might fail without specific options or if blocked by browser
    debugPrint("Firebase initialization failed (Expected if not configured): $e");
  }
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: const KhiddaApp(),
    ),
  );
}

class KhiddaApp extends StatelessWidget {
  const KhiddaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: 'Khidda',
      debugShowCheckedModeBanner: false,
      locale: settings.locale,
      themeMode: settings.themeMode,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('bn'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green,
          secondary: Colors.amber,
          surface: Colors.grey[50],
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
          primary: Colors.green,
          secondary: Colors.amber,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFF1B5E20),
          foregroundColor: Colors.white,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
