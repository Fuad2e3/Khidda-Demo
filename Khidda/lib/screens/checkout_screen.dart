import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import '../providers/cart_provider.dart';
import '../services/payment_service.dart';
import 'order_success_screen.dart';
import '../utils/l10n.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final PaymentService _paymentService = PaymentService();
  final TextEditingController _promoController = TextEditingController();
  bool _isProcessing = false;
  double _discount = 0.0;

  void _applyPromo() {
    if (_promoController.text.toUpperCase() == 'KHIDDA20') {
      setState(() {
        _discount = 0.20; // 20% discount
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Promo code applied: 20% OFF'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid promo code'), backgroundColor: Colors.red),
      );
    }
  }

  void _placeOrder(CartProvider cart) async {
    if (cart.itemCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your cart is empty!')),
      );
      return;
    }

    setState(() => _isProcessing = true);
    
    double subtotal = cart.totalAmount;
    double discountAmount = subtotal * _discount;
    double total = subtotal - discountAmount + 2.50;

    // Process Payment
    final success = await _paymentService.processPayment(total);
    
    if (success) {
      cart.clear(); // Clear cart on success
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
      );
    } else {
      if (!mounted) return;
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    double subtotal = cart.totalAmount;
    double discountAmount = subtotal * _discount;
    double total = subtotal - discountAmount + 2.50;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.translate('checkout')),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: cart.itemCount == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Text(
              l10n.translate('order_summary'),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cart.items.length,
                          itemBuilder: (ctx, i) {
                            final item = cart.items.values.toList()[i];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item.dish.name, 
                                maxLines: 1, 
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text('Qty: ${item.quantity}'),
                              trailing: Text('\$${(item.dish.price * item.quantity).toStringAsFixed(2)}'),
                            );
                          },
                        ),
                      ),
                      const Divider(),
                      _buildPriceRow('Subtotal', subtotal),
                      if (_discount > 0)
                        _buildPriceRow('Discount (20%)', -discountAmount, color: Colors.red),
                      _buildPriceRow('Delivery Fee', 2.50),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Text('\$${total.toStringAsFixed(2)}', 
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Promo Code', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promoController,
                    decoration: InputDecoration(
                      hintText: 'Enter code (e.g. KHIDDA20)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _applyPromo,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  child: const Text('Apply'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.green),
              title: const Text('123 Maple St, Toronto, ON'),
              trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
            ),
            const SizedBox(height: 16),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.credit_card, color: Colors.green),
              title: const Text('Visa ending in 4242'),
              trailing: IconButton(icon: const Icon(Icons.keyboard_arrow_right), onPressed: () {}),
            ),
            const SizedBox(height: 24),
            _isProcessing
              ? const Center(child: CircularProgressIndicator())
              : CustomButton(
                  text: 'Place Order',
                  onPressed: () => _placeOrder(cart),
                  color: Colors.green,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {Color color = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: color)),
          Text(
            '${amount < 0 ? "-" : ""}\$${amount.abs().toStringAsFixed(2)}',
            style: TextStyle(color: color, fontWeight: color == Colors.red ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
