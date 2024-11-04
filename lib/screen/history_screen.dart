// lib/screen/history_screen.dart

import 'package:flutter/material.dart';
import '../model/transaction.dart';
import '../screen/transaction_detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Lịch sử giao dịch',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_outlined, color: Colors.green),
            onPressed: () {},
          ),
        ],
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildFilters(),
                _buildStatusTabs(),
              ],
            ),
          ),
          Expanded(
            child: _buildTransactionList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterButton('Tất cả các ngày'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildFilterButton('Tất cả'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildStatusTab('Tất cả', isSelected: true),
          _buildStatusTab('Thành công'),
          _buildStatusTab('Đang xử lý'),
          _buildStatusTab('Thất bại'),
        ],
      ),
    );
  }

  Widget _buildStatusTab(String text, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.shade50 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.green : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    return ListView(
      children: [
        _buildMonthHeader('Tháng 10'),
        _buildTransactionItem(
          context: context,
          icon: Icons.shopping_bag_outlined,
          title: 'Thanh toán',
          subtitle: 'Shopee',
          amount: '-đ16.000',
          date: '20 Tháng 10 2024',
          color: Colors.deepOrange,
          transaction: TransactionModel(
            id: '12518587604462783',
            referenceId: '7645967930511519',
            amount: 16000,
            recipient: 'Shopee',
            timestamp: DateTime(2024, 10, 20, 19, 48),
            status: 'Thành công',
            paymentMethod: 'BVBank',
            recipientIcon: 'S',
          ),
        ),
        _buildTransactionItem(
          context: context,
          icon: Icons.phone_android,
          title: 'Thanh toán',
          subtitle: 'Mobile Topup',
          amount: '-đ99.000',
          date: '08 Tháng 10 2024',
          color: Colors.teal,
          transaction: TransactionModel(
            id: '12518587604462784',
            referenceId: '7645967930511520',
            amount: 99000,
            recipient: 'Mobile Topup',
            timestamp: DateTime(2024, 10, 8, 15, 30),
            status: 'Thành công',
            paymentMethod: 'BVBank',
            recipientIcon: 'M',
          ),
        ),
        _buildMonthHeader('Tháng 9'),
        _buildTransactionItem(
          context: context,
          icon: Icons.account_balance_wallet,
          title: 'Hoàn Tiền',
          subtitle: 'Từ Shopee',
          amount: '+đ11.500',
          date: '27 Tháng 9 2024',
          color: Colors.teal,
          isRefund: true,
          transaction: TransactionModel(
            id: '12518587604462785',
            referenceId: '7645967930511521',
            amount: 11500,
            recipient: 'Shopee',
            timestamp: DateTime(2024, 9, 27, 14, 20),
            status: 'Thành công',
            paymentMethod: 'BVBank',
            recipientIcon: 'S',
          ),
        ),
        _buildTransactionItem(
          context: context,
          icon: Icons.shopping_bag_outlined,
          title: 'Thanh toán',
          subtitle: 'Shopee',
          amount: '-đ11.500',
          date: '27 Tháng 9 2024',
          color: Colors.deepOrange,
          transaction: TransactionModel(
            id: '12518587604462786',
            referenceId: '7645967930511522',
            amount: 11500,
            recipient: 'Shopee',
            timestamp: DateTime(2024, 9, 27, 14, 15),
            status: 'Thành công',
            paymentMethod: 'BVBank',
            recipientIcon: 'S',
          ),
        ),
      ],
    );
  }

  Widget _buildMonthHeader(String month) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        month,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required String date,
    required Color color,
    required TransactionModel transaction,
    bool isRefund = false,
  }) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            Text(
              date,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        trailing: Text(
          amount,
          style: TextStyle(
            color: isRefund ? Colors.green : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionDetailScreen(
                transaction: transaction,
              ),
            ),
          );
        },
      ),
    );
  }
}