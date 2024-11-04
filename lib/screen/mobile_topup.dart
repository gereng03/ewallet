// lib/screens/top_up_screen.dart

import 'package:flutter/material.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({Key? key}) : super(key: key);

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  String selectedCarrier = 'Viettel';
  final TextEditingController _phoneController = TextEditingController();
  String? selectedAmount;

  void _showCarrierSelection() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CarrierSelectionSheet(
        selectedCarrier: selectedCarrier,
        onSelect: (carrier) {
          setState(() {
            selectedCarrier = carrier;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 20),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
          title: const Text(
            'Nạp Tiền',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Điện Thoại'),
              Tab(text: 'Data'),
            ],
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey[600],
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            indicatorColor: Colors.green,
            indicatorWeight: 2,
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Nhập số điện thoại',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            isDense: true,
                          ),
                        ),
                      ),
                      if (_phoneController.text.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.grey[400], size: 20),
                          onPressed: () {
                            setState(() {
                              _phoneController.clear();
                            });
                          },
                        ),
                      IconButton(
                        icon: Icon(Icons.person_add_outlined, color: Colors.grey[400], size: 20),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: _showCarrierSelection,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey[100],
                            ),
                            child: Image.asset(
                              'assets/logos/${selectedCarrier.toLowerCase()}.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            selectedCarrier,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _buildAmountOption('10.000', 'đ10.000'),
                  _buildAmountOption('20.000', 'đ20.000'),
                  _buildAmountOption('30.000', 'đ30.000'),
                  _buildAmountOption('50.000', 'đ50.000'),
                  _buildAmountOption('100.000', 'đ100.000'),
                  _buildAmountOption('200.000', 'đ200.000'),
                  _buildAmountOption('300.000', 'đ300.000'),
                  _buildAmountOption('500.000', 'đ500.000'),
                  _buildAmountOption('1.000.000', 'đ995.000', discount: '-1%'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: selectedAmount != null ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  disabledBackgroundColor: Colors.grey[200],
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Thanh Toán',
                  style: TextStyle(
                    color: selectedAmount != null ? Colors.white : Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountOption(String amount, String price, {String? discount}) {
    final isSelected = selectedAmount == amount;

    return InkWell(
      onTap: () {
        setState(() {
          selectedAmount = amount;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      amount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.green : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Giá: $price',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (discount != null)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    discount,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.orange[800],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CarrierSelectionSheet extends StatelessWidget {
  final String selectedCarrier;
  final Function(String) onSelect;

  const CarrierSelectionSheet({
    Key? key,
    required this.selectedCarrier,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chọn Nhà Cung Cấp',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(),
          ListView(
            shrinkWrap: true,
            children: [
              _buildCarrierOption('Vinaphone', context),
              _buildCarrierOption('MobiFone', context),
              _buildCarrierOption('Viettel', context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCarrierOption(String carrier, BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[100],
        ),
        child: Image.asset(
          'assets/logos/${carrier.toLowerCase()}.png',
          width: 32,
          height: 32,
        ),
      ),
      title: Text(carrier),
      trailing: selectedCarrier == carrier
          ? const Icon(Icons.check, color: Colors.deepOrange)
          : null,
      onTap: () => onSelect(carrier),
    );
  }
}