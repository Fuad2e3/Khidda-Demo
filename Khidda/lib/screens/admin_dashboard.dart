import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildStatCard('Active Orders', '12', Icons.receipt_long, Colors.blue),
          _buildStatCard('Today\'s Revenue', '\$1,420.50', Icons.attach_money, Colors.green),
          _buildStatCard('Out of Stock', '3', Icons.warning_amber, Colors.orange),
          const SizedBox(height: 30),
          const Text('Recent Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildOrderTile('ORD-5541', 'Beef Biryani x 2', 'Preparing'),
          _buildOrderTile('ORD-5540', 'Chicken Roast x 1', 'Delivered'),
          _buildOrderTile('ORD-5539', 'Mutton Kacchi x 3', 'Out for Delivery'),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withValues(alpha: 0.1), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        trailing: Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildOrderTile(String id, String items, String status) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(items),
      trailing: Chip(label: Text(status, style: const TextStyle(fontSize: 10))),
    );
  }
}
