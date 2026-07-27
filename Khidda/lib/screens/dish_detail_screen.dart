import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dish.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/custom_button.dart';

class DishDetailScreen extends StatefulWidget {
  final Dish dish;
  const DishDetailScreen({super.key, required this.dish});

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  int _quantity = 1;
  final Set<String> _selectedCustomizations = {};
  String _spicyLevel = 'Medium';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final wishlist = Provider.of<WishlistProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.dish.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
              ),
            ),
            backgroundColor: Colors.green,
            actions: [
              IconButton(
                icon: Icon(
                  wishlist.isFavorite(widget.dish.id) ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () => wishlist.toggleFavorite(widget.dish.id),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.dish.name,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '\$${widget.dish.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        widget.dish.rating.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.timer_outlined, color: Colors.grey, size: 20),
                      const SizedBox(width: 4),
                      const Text('20-30 min', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.dish.description,
                    style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Spice Level',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: ['Mild', 'Medium', 'Spicy'].map((level) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(level),
                          selected: _spicyLevel == level,
                          onSelected: (selected) {
                            if (selected) setState(() => _spicyLevel = level);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Extras',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...['Extra Rice', 'Extra Meat', 'Extra Salad'].map((extra) {
                    return CheckboxListTile(
                      title: Text(extra),
                      value: _selectedCustomizations.contains(extra),
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            _selectedCustomizations.add(extra);
                          } else {
                            _selectedCustomizations.remove(extra);
                          }
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  }),
                  const SizedBox(height: 24),
                  const Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _quantityControl(Icons.remove, () {
                        if (_quantity > 1) setState(() => _quantity--);
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('$_quantity', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      _quantityControl(Icons.add, () {
                        setState(() => _quantity++);
                      }),
                    ],
                  ),
                  const SizedBox(height: 120), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: CustomButton(
          text: 'Add to Cart - \$${(widget.dish.price * _quantity).toStringAsFixed(2)}',
          onPressed: () {
            // Note: In a real app, you'd create a new Dish object with these choices
            // or pass metadata to CartProvider. For now, we just add the base dish quantity.
            for (int i = 0; i < _quantity; i++) {
              cart.addItem(widget.dish);
            }
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${widget.dish.name} ($_spicyLevel) added to cart!'), 
                backgroundColor: Colors.green
              ),
            );
          },
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _quantityControl(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 24, color: Colors.green),
      ),
    );
  }
}
