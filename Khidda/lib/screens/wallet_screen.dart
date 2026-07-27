import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Khidda Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 10))],
              ),
              child: const Column(
                children: [
                  Text('Available Balance', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  SizedBox(height: 12),
                  Text('\$45.50', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  _TransactionItem(title: 'Order #12345', date: 'Oct 24, 2023', amount: -18.49),
                  _TransactionItem(title: 'Added Funds', date: 'Oct 20, 2023', amount: 50.00),
                  _TransactionItem(title: 'Order #11290', date: 'Oct 12, 2023', amount: -12.50),
                ],
              ),
            ),
            CustomButton(
              text: 'Add Money',
              onPressed: () {},
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String title;
  final String date;
  final double amount;

  const _TransactionItem({required this.title, required this.date, required this.amount});

  @override
  Widget build(BuildContext context) {
    bool isDebit = amount < 0;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(date),
      trailing: Text(
        '${isDebit ? "" : "+"}\$${amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: isDebit ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
