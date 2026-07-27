import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dish.dart';
import '../widgets/dish_card.dart';
import '../services/api_service.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  List<Dish> _dishes = [];

  @override
  void initState() {
    super.initState();
    _fetchMenu();
  }

  Future<void> _fetchMenu() async {
    try {
      final menu = await _apiService.getMenu();
      setState(() {
        _dishes = menu;
        _isLoading = false;
      });
    } catch (e) {
      // Fallback to mock data if API fails (typical for local dev)
      setState(() {
        _dishes = _mockDishes;
        _isLoading = false;
      });
    }
  }

  // Mock data for demo fallback
  final List<Dish> _mockDishes = [
    Dish(
      id: '1',
      name: 'Beef Biryani',
      description: 'Authentic Bangladeshi style beef biryani with aromatic chinigura rice and tender beef.',
      price: 15.99,
      imageUrl: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      rating: 4.8,
    ),
    Dish(
      id: '2',
      name: 'Bhuna Khichuri',
      description: 'Traditional yellow lentils and rice cooked with spices, served with egg curry.',
      price: 12.50,
      imageUrl: 'https://images.unsplash.com/photo-1605493722102-42173b223c72?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      rating: 4.5,
    ),
    Dish(
      id: '3',
      name: 'Chicken Roast',
      description: 'Slow-cooked chicken in a rich, creamy and spicy yogurt-based gravy.',
      price: 13.99,
      imageUrl: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      rating: 4.7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khidda Menu', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              label: Text(cart.itemCount.toString()),
              isLabelVisible: cart.itemCount > 0,
              child: ch,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.green[50],
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.green),
                const SizedBox(width: 8),
                const Text('Delivering to: ', style: TextStyle(fontWeight: FontWeight.bold)),
                const Expanded(child: Text('Toronto, ON, Canada', overflow: TextOverflow.ellipsis)),
                TextButton(onPressed: () {}, child: const Text('Change')),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _fetchMenu,
                    child: ListView.builder(
                      itemCount: _dishes.length,
                      itemBuilder: (context, index) {
                        return DishCard(
                          dish: _dishes[index],
                          onTap: () {
                            // Show dish details
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
