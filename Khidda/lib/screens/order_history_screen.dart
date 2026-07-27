import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock history data
    final List<Map<String, dynamic>> mockHistory = [
      {
        'id': 'ORD-9821',
        'date': 'Oct 24, 2023',
        'total': 25.50,
        'status': 'Delivered',
        'items': 'Beef Biryani x 1, Drinks x 2'
      },
      {
        'id': 'ORD-8742',
        'date': 'Oct 15, 2023',
        'total': 12.00,
        'status': 'Delivered',
        'items': 'Chicken Roast x 1'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockHistory.length,
        itemBuilder: (context, index) {
          final order = mockHistory[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order['id'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          order['status'],
                          style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(order['items'], style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(order['date'], style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                      Text(
                        '\$${order['total'].toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  const Divider(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.reorder, size: 18),
                      label: const Text('Re-order'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
