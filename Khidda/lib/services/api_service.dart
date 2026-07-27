import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dish.dart';
import '../models/order.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/api'; // Update with actual backend URL

  Future<List<Dish>> getMenu() async {
    final response = await http.get(Uri.parse('$baseUrl/menu'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((dish) => Dish.fromJson(dish)).toList();
    } else {
      throw Exception('Failed to load menu');
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
