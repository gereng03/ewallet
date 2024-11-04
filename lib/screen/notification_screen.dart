import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Promotion Section
            const NotificationItem(
              icon: Icon(Icons.attach_money, color: Colors.white, size: 24),
              iconBackground: Colors.amber,
              title: 'Khuyến mãi',
              subtitle: 'Viettel khuyến mãi 20%',
              badge: '99+',
              time: null,
            ),

            // ShopeePay Update Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.grey[100],
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cập nhật ShopeePay'),
                  Text('Đọc tất cả(45)',
                      style: TextStyle(color: Colors.green)),
                ],
              ),
            ),

            // Transaction notifications
            const NotificationItem(
              icon: Icon(Icons.payment, color: Colors.white, size: 24),
              iconBackground: Colors.green,
              title: 'Giao dịch thanh toán thành công',
              subtitle: 'Giao dịch 764596793051519 thanh toán thành công qua ShopeePay. Số tiền đ16,000 đã được trừ.',
              time: '20-10-2024 19:48',
            ),

            const NotificationItem(
              icon: Icon(Icons.payment, color: Colors.white, size: 24),
              iconBackground: Colors.green,
              title: 'Giao dịch thanh toán thành công',
              subtitle: 'Giao dịch 687151023481519 thanh toán thành công qua ShopeePay. Số tiền đ99,000 đã được trừ.',
              time: '08-10-2024 18:30',
            ),

            const NotificationItem(
              icon: Icon(Icons.card_giftcard, color: Colors.white, size: 24),
              iconBackground: Colors.green,
              title: 'Bạn đã nhận được ưu đãi!',
              subtitle: 'Voucher Ưu đãi đối tác ShopeePay - Giảm 5.000Đ cho đơn từ 100.000Đ đã có trong Ví ShopeePay của bạn. Sử dụng ngay nhé!',
              time: '07-10-2024 12:10',
            ),

            const NotificationItem(
              icon: Icon(Icons.money, color: Colors.white, size: 24),
              iconBackground: Colors.green,
              title: 'Hoàn tất hoàn tiền về ShopeePay',
              subtitle: 'Yêu cầu hoàn tiền về Ví ShopeePay đã được xử lý thành công với số tiền đ11,500.',
              time: '27-09-2024 11:29',
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Icon icon;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final String? badge;
  final String? time;

  const NotificationItem({
    Key? key,
    required this.icon,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    this.badge,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          badge!,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                if (time != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    time!,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}