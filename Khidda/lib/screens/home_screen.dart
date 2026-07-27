import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dish.dart';
import '../widgets/dish_card.dart';
import '../widgets/home_widgets.dart';
import '../widgets/shimmer_widgets.dart';
import '../services/api_service.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';
import 'profile_screen.dart';
import 'dish_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  List<Dish> _allDishes = [];
  List<Dish> _filteredDishes = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchMenu();
  }

  Future<void> _fetchMenu() async {
    try {
      final menu = await _apiService.getMenu();
      setState(() {
        _allDishes = menu;
        _applyFilters();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _allDishes = _mockDishes;
        _applyFilters();
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredDishes = _allDishes.where((dish) {
        bool matchesCategory = _selectedCategory == 'All' || 
            dish.name.toLowerCase().contains(_selectedCategory.toLowerCase()) ||
            dish.description.toLowerCase().contains(_selectedCategory.toLowerCase());
        bool matchesSearch = dish.name.toLowerCase().contains(_searchQuery.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  // Mock data for demo fallback
  final List<Dish> _mockDishes = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KHIDDA', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              label: Text(cart.itemCount.toString()),
              isLabelVisible: cart.itemCount > 0,
              child: ch,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutScreen()));
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchMenu,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const PromoSlider(),
                  const SizedBox(height: 16),
                  HomeSearchBar(onChanged: (val) {
                    _searchQuery = val;
                    _applyFilters();
                  }),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  CategorySelector(onCategorySelected: (cat) {
                    _selectedCategory = cat;
                    _applyFilters();
                  }),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Popular Near You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            _isLoading
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const DishCardShimmer(),
                      childCount: 3,
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => DishCard(
                          dish: _filteredDishes[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DishDetailScreen(dish: _filteredDishes[index]),
                              ),
                            );
                          },
                        ),
                        childCount: _filteredDishes.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
