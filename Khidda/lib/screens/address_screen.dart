import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Delivery Addresses')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Add New Address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: () {
                    if (_addressController.text.isNotEmpty) {
                      userProvider.updateAddress(_addressController.text);
                      _addressController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Address saved!')),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Your Saved Addresses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            if (userProvider.userProfile?.address != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.home, color: Colors.green),
                  title: Text(userProvider.userProfile!.address!),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('No addresses saved yet.', style: TextStyle(color: Colors.grey)),
              ),
          ],
        ),
      ),
    );
  }
}
