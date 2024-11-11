// lib/screen/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zalo2222/screen/personel_screen.dart';
import '../screen/intro_screen.dart';
import '../service/auth_service.dart';
import '../service/navigation_service.dart';
import '../service/notification_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _handleSignOut(BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Đăng xuất',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        // Reset all services
        Provider.of<NavigationService>(context, listen: false).reset();
        Provider.of<NotificationService>(context, listen: false).reset();

        // Perform sign out
        final authService = Provider.of<AuthService>(context, listen: false);
        await authService.signOut();

        // Close loading indicator
        if (context.mounted) {
          Navigator.of(context).pop();
        }

        // Navigate to intro screen and remove all previous routes
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const IntroScreen()),
                (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        // Close loading indicator if still showing
        if (context.mounted) {
          Navigator.of(context).pop();
        }

        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Đã có lỗi xảy ra: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 60, // Increased top padding to move content down
        bottom: 20,
      ),
      color: Colors.green,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Colors.grey[400]),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    '****33',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Đã xác thực',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          _buildProfileHeader(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: ListView(
                  // Remove default padding
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 10), // Add some spacing at the top
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: 'Hồ sơ',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PersonalScreen()),
                        );
                      },
                    ),
                    // _buildMenuItem(
                    //   icon: Icons.attach_money,
                    //   title: 'Shopee Xu',
                    //   onTap: () {},
                    // ),
                    _buildMenuItem(
                      icon: Icons.receipt_long_outlined,
                      title: 'Đơn Nạp thẻ & Dịch vụ',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.local_offer_outlined,
                      title: 'Kho Voucher',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.settings_outlined,
                      title: 'Cài đặt',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: 'Trung tâm trợ giúp',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.exit_to_app,
                      title: 'Đăng xuất',
                      onTap: () => _handleSignOut(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}