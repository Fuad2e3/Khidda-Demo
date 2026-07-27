import 'package:flutter/material.dart';
import '../models/dish.dart';
import '../models/order.dart';

class CartProvider with ChangeNotifier {
  final Map<String, OrderItem> _items = {};

  Map<String, OrderItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.dish.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Dish dish) {
    if (_items.containsKey(dish.id)) {
      _items.update(
        dish.id,
        (existing) => OrderItem(
          dish: existing.dish,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        dish.id,
        () => OrderItem(dish: dish, quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String dishId) {
    _items.remove(dishId);
    notifyListeners();
  }

  void removeSingleItem(String dishId) {
    if (!_items.containsKey(dishId)) return;
    if (_items[dishId]!.quantity > 1) {
      _items.update(
        dishId,
        (existing) => OrderItem(
          dish: existing.dish,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _items.remove(dishId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
