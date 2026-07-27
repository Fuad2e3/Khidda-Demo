import 'package:flutter/material.dart';
import 'feedback_screen.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Icon(Icons.delivery_dining, size: 80, color: Colors.green),
                const SizedBox(height: 16),
                const Text(
                  'Order #12345',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Estimated Delivery: 20-30 mins',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Stepper(
              physics: const ClampingScrollPhysics(),
              currentStep: _currentStep,
              controlsBuilder: (context, details) => Container(),
              steps: [
                const Step(
                  title: Text('Order Placed'),
                  subtitle: Text('We have received your order'),
                  content: SizedBox.shrink(),
                  isActive: true,
                  state: StepState.complete,
                ),
                Step(
                  title: const Text('Preparing'),
                  subtitle: const Text('Chef is cooking your meal'),
                  content: const SizedBox.shrink(),
                  isActive: _currentStep >= 1,
                  state: _currentStep > 1 ? StepState.complete : StepState.editing,
                ),
                Step(
                  title: const Text('Out for Delivery'),
                  subtitle: const Text('Rider is on the way'),
                  content: const SizedBox.shrink(),
                  isActive: _currentStep >= 2,
                  state: _currentStep > 2 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Delivered'),
                  subtitle: const Text('Enjoy your meal!'),
                  content: const SizedBox.shrink(),
                  isActive: _currentStep >= 3,
                  state: _currentStep == 3 ? StepState.complete : StepState.indexed,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 3) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                  );
                }
              },
              child: Text(_currentStep < 3 ? 'Next Stage (Demo)' : 'Rate your meal'),
            ),
          ),
        ],
      ),
    );
  }
}
