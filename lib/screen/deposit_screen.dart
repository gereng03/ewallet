import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amountController = TextEditingController();
  final NumberFormat currencyFormat = NumberFormat("#,##0", "vi_VN");
  final double currentBalance = 2500;
  String? selectedAmount; // Add this to track selected amount

  void _handleQuickAmount(String amount) {
    setState(() {
      selectedAmount = amount;
      _amountController.text = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Nạp tiền',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nhập số tiền (đ)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  // Clear selection if manually typed amount doesn't match any quick amount
                  if (value != selectedAmount) {
                    setState(() {
                      selectedAmount = null;
                    });
                  }
                },
                decoration: InputDecoration(
                  prefixText: 'đ ',
                  prefixStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _amountController.clear();
                        selectedAmount = null;
                      });
                    },
                  ),
                ),
              ),
              Text(
                'Số dư Ví hiện tại: đ${currencyFormat.format(currentBalance)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAmountButton('100.000'),
                  _buildQuickAmountButton('200.000'),
                  _buildQuickAmountButton('500.000'),
                ],
              ),
              const SizedBox(height: 24),
              _buildPaymentMethod(),
              const SizedBox(height: 24),
              _buildSummary(),
              const SizedBox(height: 16),
              _buildTermsAndConditions(),
              const SizedBox(height: 24),
              _buildDepositButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAmountButton(String amount) {
    final bool isSelected = amount == selectedAmount;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: OutlinedButton(
          onPressed: () => _handleQuickAmount(amount),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isSelected ? Colors.green : Colors.grey.shade300,
              width: isSelected ? 2 : 1, // Thicker border for selected button
            ),
            backgroundColor: isSelected ? Colors.green.withOpacity(0.1) : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            amount,
            style: TextStyle(
              color: isSelected ? Colors.green : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Image.asset(
          'assets/bvbank_logo.png',
          width: 40,
          height: 40,
          errorBuilder: (context, error, stackTrace) =>
              Container(
                width: 40,
                height: 40,
                color: Colors.grey.shade200,
                child: const Icon(Icons.account_balance, color: Colors.grey),
              ),
        ),
        title: const Text('Phương thức thanh toán'),
        subtitle: const Text('BVBank [* 9068]'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Handle payment method selection
        },
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Nạp tiền'),
            Text(
              'đ${_amountController.text.isEmpty ? "0" : _amountController.text}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tổng thanh toán'),
            Text(
              'đ${_amountController.text.isEmpty ? "0" : _amountController.text}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        const Icon(Icons.info_outline, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              children: [
                const TextSpan(text: 'Nhấn "Nạp tiền ngay", bạn đã đồng ý tuân theo '),
                TextSpan(
                  text: 'Điều khoản sử dụng',
                  style: const TextStyle(color: Colors.blue),
                  onEnter: (event) {/* Handle tap */},
                ),
                const TextSpan(text: ' và '),
                TextSpan(
                  text: 'Chính sách bảo mật',
                  style: const TextStyle(color: Colors.blue),
                  onEnter: (event) {/* Handle tap */},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDepositButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle deposit action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Nạp tiền ngay',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}