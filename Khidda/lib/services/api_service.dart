import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dish.dart';
import '../models/order.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/api'; // Update with actual backend URL

  Future<List<Dish>> getMenu() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/menu')).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((dish) => Dish.fromJson(dish)).toList();
      } else {
        throw Exception('Failed to load menu');
      }
    } catch (e) {
      // Return a richer mock set for a better fallback experience
      return [
        Dish(
          id: '1',
          name: 'Beef Biryani (Premium)',
          description: 'Authentic Bangladeshi style beef biryani with aromatic chinigura rice and tender beef.',
          price: 15.99,
          imageUrl: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          rating: 4.8,
        ),
        Dish(
          id: '2',
          name: 'Bhuna Khichuri with Egg',
          description: 'Traditional yellow lentils and rice cooked with spices, served with two egg curries.',
          price: 12.50,
          imageUrl: 'https://images.unsplash.com/photo-1605493722102-42173b223c72?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          rating: 4.5,
        ),
        Dish(
          id: '3',
          name: 'Classic Chicken Roast',
          description: 'Slow-cooked chicken in a rich, creamy and spicy yogurt-based gravy. Perfect for festivities.',
          price: 13.99,
          imageUrl: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          rating: 4.7,
        ),
        Dish(
          id: '4',
          name: 'Mutton Kacchi Biryani',
          description: 'The king of all biryanis. Succulent mutton pieces slow-cooked with Basmati rice.',
          price: 18.99,
          imageUrl: 'https://images.unsplash.com/photo-1633945274405-b6c8069047b0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          rating: 4.9,
        ),
        Dish(
          id: '5',
          name: 'Special Borhani',
          description: 'Traditional yogurt-based digestive drink with spices and mint. Best with Biryani.',
          price: 3.50,
          imageUrl: 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          rating: 4.6,
        ),
      ];
    }
  }

  Future<Order> placeOrder(Order order) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to place order');
    }
  }

  Future<OrderStatus> getOrderStatus(String orderId) async {
    final response = await http.get(Uri.parse('$baseUrl/orders/status/$orderId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return OrderStatus.values.firstWhere((e) => e.name == jsonResponse['status']);
    } else {
      throw Exception('Failed to get order status');
    }
  }
}
