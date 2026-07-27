import 'package:flutter/material.dart';
import '../models/dish.dart';

class WishlistProvider with ChangeNotifier {
  final Set<String> _wishlistIds = {};

  Set<String> get wishlistIds => _wishlistIds;

  bool isFavorite(String dishId) => _wishlistIds.contains(dishId);

  void toggleFavorite(String dishId) {
    if (_wishlistIds.contains(dishId)) {
      _wishlistIds.remove(dishId);
    } else {
      _wishlistIds.add(dishId);
    }
    notifyListeners();
  }
}
