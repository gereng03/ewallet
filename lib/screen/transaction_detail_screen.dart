// lib/screen/transaction_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/transaction.dart';
import '../utils/number_formatter.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã sao chép')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chi tiết thanh toán',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildAmountCard(),
                    const SizedBox(height: 12),
                    _buildRecipientCard(),
                    const SizedBox(height: 12),
                    _buildTransactionInfoCard(context),
                    const SizedBox(height: 12),
                    // _buildContactCard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '-đ${formatCurrency(transaction.amount)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 6),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 16,
                  ),
                ),
                Text(
                  'Thành công',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Thời gian hoàn thành ${_formatDateTime(transaction.timestamp)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipientCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thanh toán cho',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'S',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Shopee',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionInfoCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin đơn hàng',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Mã tham chiếu giao dịch',
              transaction.referenceId,
              hasCopyButton: true,
              onCopy: () => _copyToClipboard(context, transaction.referenceId),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Mã giao dịch', transaction.id),
            const SizedBox(height: 16),
            _buildInfoRow('Phương thức thanh toán', transaction.paymentMethod),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool hasCopyButton = false, VoidCallback? onCopy}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (hasCopyButton)
              GestureDetector(
                onTap: onCopy,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Sao chép',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Widget _buildContactCard() {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(horizontal: 16),
  //     elevation: 0,
  //     color: Colors.white,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         children: [
  //           Text(
  //             'Liên hệ ShopeePay',
  //             style: TextStyle(
  //               fontSize: 14,
  //               color: Colors.grey[600],
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {},
  //             style: TextButton.styleFrom(
  //               padding: const EdgeInsets.symmetric(vertical: 8),
  //               minimumSize: Size.zero,
  //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //             ),
  //             child: const Text(
  //               'Liên hệ: 1900 6906',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 fontSize: 14,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}