import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/settings_provider.dart';
import '../services/auth_service.dart';
import 'order_history_screen.dart';
import 'wishlist_screen.dart';
import 'address_screen.dart';
import 'wallet_screen.dart';
import 'admin_dashboard.dart';
import 'order_tracking_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 60, color: Colors.green),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userProvider.userProfile?.name ?? 'Guest User',
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userProvider.userProfile?.email ?? 'login to see more',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileItem(
              icon: Icons.history,
              title: 'Order History',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
              },
            ),
            _buildProfileItem(
              icon: Icons.favorite_border,
              title: 'My Favorites',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen()));
              },
            ),
            _buildProfileItem(
              icon: Icons.location_on_outlined,
              title: 'Delivery Addresses',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressScreen()));
              },
            ),
            _buildProfileItem(
              icon: Icons.payment,
              title: 'Khidda Wallet',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletScreen()));
              },
            ),
            _buildProfileItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                context.read<SettingsProvider>().toggleLanguage();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Language Toggled (English/Bangla)')),
                );
              },
            ),
            _buildProfileItem(
              icon: Icons.map_outlined,
              title: 'Live Tracking (Demo)',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderTrackingScreen()));
              },
            ),
            _buildProfileItem(
              icon: Icons.admin_panel_settings_outlined,
              title: 'Admin Dashboard',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard()));
              },
            ),
            const Divider(),
            _buildProfileItem(
              icon: Icons.logout,
              title: 'Logout',
              color: Colors.red,
              onTap: () async {
                await authService.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(icon, color: color == Colors.red ? Colors.red : Colors.green),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
