import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'home': 'Home',
      'wishlist': 'Wishlist',
      'cart': 'Cart',
      'profile': 'Profile',
      'search_hint': 'Search for dishes...',
      'categories': 'Categories',
      'popular': 'Popular Near You',
      'special_offer': 'Special Offer: 20% OFF',
      'add_to_cart': 'Add to Cart',
      'checkout': 'Checkout',
      'order_summary': 'Order Summary',
      'place_order': 'Place Order',
      'track_order': 'Track Order',
    },
    'bn': {
      'home': 'হোম',
      'wishlist': 'পছন্দ',
      'cart': 'কার্ট',
      'profile': 'প্রোফাইল',
      'search_hint': 'খাবার খুঁজুন...',
      'categories': 'বিভাগ',
      'popular': 'আপনার আসেপাশে জনপ্রিয়',
      'special_offer': 'বিশেষ অফার: ২০% ছাড়',
      'add_to_cart': 'কার্টে যোগ করুন',
      'checkout': 'চেকআউট',
      'order_summary': 'অর্ডারের বিবরণ',
      'place_order': 'অর্ডার করুন',
      'track_order': 'অর্ডার ট্র্যাক করুন',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'bn'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
