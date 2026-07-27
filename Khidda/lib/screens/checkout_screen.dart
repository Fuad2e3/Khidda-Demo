import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import '../providers/cart_provider.dart';
import '../services/payment_service.dart';
import 'order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final PaymentService _paymentService = PaymentService();
  bool _isProcessing = false;

  void _placeOrder(CartProvider cart) async {
    if (cart.itemCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your cart is empty!')),
      );
      return;
    }

    setState(() => _isProcessing = true);
    
    // Process Payment
    final success = await _paymentService.processPayment(cart.totalAmount + 2.50);
    
    if (success) {
      cart.clear(); // Clear cart on success
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrderTrackingScreen()),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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
                              title: Text(item.dish.name),
                              subtitle: Text('Qty: ${item.quantity}'),
                              trailing: Text('\$${(item.dish.price * item.quantity).toStringAsFixed(2)}'),
                            );
                          },
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.between,
                        children: [
                          const Text('Subtotal'),
                          Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.between,
                        children: [
                          Text('Delivery Fee'),
                          Text('\$2.50'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.between,
                        children: [
                          const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Text('\$${(cart.totalAmount + 2.50).toStringAsFixed(2)}', 
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
}
