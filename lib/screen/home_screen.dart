import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zalo2222/screen/contact_screen.dart';
import '../provider/wallet_provider.dart';
import 'deposit_screen.dart';
import 'mobile_topup.dart';
import 'qr_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBalanceVisible = true;

  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      Provider.of<WalletProvider>(context, listen: false).initWalletStream(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildQuickActions(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: _buildServices(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.shop_outlined, color: Colors.green),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Chào buổi tối',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        'S',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '0',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'E-Wallet',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
                child: Icon(
                    _isBalanceVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Colors.white.withOpacity(0.8)
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Consumer<WalletProvider>(
            builder: (context, walletProvider, child) {
              return Row(
                children: [
                  Text(
                    _isBalanceVisible
                        ? 'đ ${walletProvider.balance.toStringAsFixed(0)}'
                        : 'đ ******',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.8)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DepositScreen()),
                );
              },
              child: _buildQuickActionItem(Icons.add_box_outlined, 'Nạp tiền'),
            ),
          ),
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactListScreen()),
                );
              },
              child: _buildQuickActionItem(Icons.sync_alt, 'Chuyển tiền'),
            ),
          ),
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRScreen()),
                );
              },
              child: _buildQuickActionItem(Icons.qr_code_scanner, 'QR Nhận tiền'),
            ),
          ),
          _buildQuickActionItem(Icons.credit_card_outlined, 'Quản lý ví'),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.green),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServices() {
    return Builder(
      builder: (BuildContext context) {
        return GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TopUpScreen()),
                );
              },
              child: _buildServiceItem(Icons.phone_android, 'Nạp Điện Thoại', Colors.teal),
            ),
            InkWell(
              onTap: () {},
              child: _buildServiceItem(Icons.wifi, 'Nạp Data 3G/4G', Colors.amber),
            ),
            InkWell(
              onTap: () {},
              child: _buildServiceItem(Icons.phone, 'Thẻ Điện Thoại - Data', Colors.blue),
            ),
            InkWell(
              onTap: () {},
              child: _buildServiceItem(Icons.lightbulb_outline, 'Thanh Toán Điện', Colors.orange),
            ),
            InkWell(
              onTap: () {},
              child: _buildServiceItem(Icons.water_drop_outlined, 'Thanh Toán Nước', Colors.blue),
            ),
            InkWell(
              onTap: () {},
              child: _buildServiceItem(Icons.router_outlined, 'Thanh Toán Internet', Colors.indigo),
            ),
            InkWell(
              onTap: () {},
              child: _buildServiceItem(Icons.calendar_today, 'Dị Động Trả Sau', Colors.red),
            ),
            InkWell(
              onTap: () {},
              child: _buildServiceItem(Icons.grid_view, 'Xem thêm dịch vụ', Colors.deepOrange),
            ),
          ],
        );
      },
    );
  }

  Widget _buildServiceItem(IconData icon, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}