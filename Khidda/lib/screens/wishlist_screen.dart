import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';
import '../models/dish.dart';
import '../widgets/dish_card.dart';
import '../services/api_service.dart';
import 'dish_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context);
    final apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: wishlist.wishlistIds.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text(
                    'Your wishlist is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : FutureBuilder<List<Dish>>(
              future: apiService.getMenu(), // In real app, filter favorites from backend
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final favoriteDishes = (snapshot.data ?? _mockDishes).where((d) => wishlist.isFavorite(d.id)).toList();
                
                if (favoriteDishes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        const Text(
                          'Your favorites will appear here',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: favoriteDishes.length,
                  itemBuilder: (context, index) {
                    final dish = favoriteDishes[index];
                    return DishCard(
                      dish: dish,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DishDetailScreen(dish: dish),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  // Mock data for demo fallback (same as HomeScreen)
  static final List<Dish> _mockDishes = [
    Dish(
      id: '1',
      name: 'Beef Biryani',
      description: 'Authentic Bangladeshi style beef biryani with aromatic rice.',
      price: 15.99,
      imageUrl: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      rating: 4.8,
    ),
    Dish(
      id: '2',
      name: 'Bhuna Khichuri',
      description: 'Traditional yellow lentils and rice served with egg curry.',
      price: 12.50,
      imageUrl: 'https://images.unsplash.com/photo-1605493722102-42173b223c72?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      rating: 4.5,
    ),
    Dish(
      id: '3',
      name: 'Chicken Roast',
      description: 'Slow-cooked chicken in a rich, creamy spicy gravy.',
      price: 13.99,
      imageUrl: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      rating: 4.7,
    ),
    Dish(
      id: '4',
      name: 'Mutton Kacchi',
      description: 'Classic dum kacchi biryani with succulent mutton pieces.',
      price: 18.50,
      imageUrl: 'https://images.unsplash.com/photo-1633945274405-b6c8069047b0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      rating: 4.9,
    ),
  ];
}
