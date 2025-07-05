import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({super.key});

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  bool showComplete = true;

  final format = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  final List<Map<String, dynamic>> allOrders = [
    {
      'name': 'Ekspresso , Arabica Coffee',
      'image': 'assets/images/1.png',
      'size': 'Small',
      'weight': '100g',
      'price': 15000,
      'date': '2025-07-07',
      'status': 'complete',
    },
    {
      'name': 'Matcha Latte',
      'image': 'assets/images/3.png',
      'size': 'Small',
      'weight': '100g',
      'price': 23000,
      'date': '2025-07-07',
      'status': 'on_process',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredOrders = allOrders
        .where((order) =>
            showComplete ? order['status'] == 'complete' : order['status'] == 'on_process')
        .toList();

    final totalPrice = filteredOrders.fold<int>(
      0,
      (sum, item) => sum + ((item['price'] as int? ?? 0)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Tab switch
            Container(
              height: 40,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  _buildTabButton('On Process', !showComplete, () {
                    setState(() => showComplete = false);
                  }),
                  _buildTabButton('Complete', showComplete, () {
                    setState(() => showComplete = true);
                  }),
                ],
              ),
            ),
            const Gap(16),

            // List Pesanan
            Expanded(
              child: filteredOrders.isEmpty
                  ? const Center(child: Text('No orders found.'))
                  : ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final item = filteredOrders[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Hagia Coffe !',
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                  Text(
                                    item['date'],
                                    style: const TextStyle(fontSize: 10, color: Colors.white),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      item['image'],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${item['size']}  •  ${item['weight']}',
                                          style: const TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                        const Gap(6),
                                        Text(
                                          format.format(item['price']),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Gap(4),
                                        Text(
                                          showComplete ? 'Order Completed' : 'Please show it to the cashier and do payment to receive your order.',
                                          style: const TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                        const Gap(10),
                                        SizedBox(
                                          height: 30,
                                          child: OutlinedButton(
                                            onPressed: () {},
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(color: Colors.white),
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              showComplete ? 'Order Again' : 'Cancel',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            // Total
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.darkActive,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                'Total ${filteredOrders.length} Menu Order ${format.format(totalPrice)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : AppColors.primary,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
