import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/custom_button.dart';
import 'order_tracking_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_yupep9et.json', // Success checkmark
                height: 200,
                repeat: false,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.check_circle, size: 100, color: Colors.green),
              ),
              const SizedBox(height: 24),
              const Text(
                'Order Successful!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your meal is on its way. You can track your order status now.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 48),
              CustomButton(
                text: 'Track Order',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderTrackingScreen()),
                  );
                },
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('Back to Home', style: TextStyle(color: Colors.green, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
