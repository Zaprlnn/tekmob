// lib/pages/cart_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:flutter_ui_coffee_shop_2/pages/payment_page.dart';
import 'package:flutter_ui_coffee_shop_2/providers/cart_provider.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Model ini sekarang digunakan oleh CartProvider
class CartItem {
  final String name;
  final String image;
  final String details;
  final double price;
  int quantity;
  bool isSelected;

  CartItem({
    required this.name,
    required this.image,
    required this.details,
    required this.price,
    this.quantity = 1,
    this.isSelected = true,
  });
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(
              color: Color(0xFF0E391F), fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      // DIUBAH: Menggunakan Consumer untuk mendapatkan data & fungsi dari CartProvider
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final discount = 2000.0; // Contoh diskon
          final total = cartProvider.subtotal - discount;

          if (cartProvider.items.isEmpty) {
            return const Center(child: Text("Keranjang Anda kosong.", style: TextStyle(fontSize: 18, color: Colors.grey)));
          }

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              ...List.generate(
                  cartProvider.items.length, (index) => _buildCartItem(context, index)),
              const Gap(24),
              _buildPromoCodeField(),
              const Gap(24),
              _buildPriceDetails('Items', formatCurrency.format(cartProvider.subtotal)),
              const Gap(8),
              _buildPriceDetails('Discounts', '-${formatCurrency.format(discount)}',
                  isDiscount: true),
              const Gap(8),
              const Divider(),
              const Gap(8),
              _buildPriceDetails('Total', formatCurrency.format(total), isTotal: true),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildCartItem(BuildContext context, int index) {
    // DIUBAH: Mengambil data dari provider
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final item = cartProvider.items[index];
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Checkbox(
              value: item.isSelected,
              // DIUBAH: Memanggil fungsi dari provider
              onChanged: (value) => cartProvider.toggleItemSelection(index, value ?? false),
              activeColor: Colors.white,
              checkColor: AppColors.primary,
              side: const BorderSide(color: Colors.white, width: 2),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(item.image,
                  width: 70, height: 70, fit: BoxFit.cover),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  const Gap(4),
                  Text(item.details,
                      style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  const Gap(8),
                  Text(formatCurrency.format(item.price),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 16, color: AppColors.primary),
                    // DIUBAH: Memanggil fungsi dari provider
                    onPressed: () => cartProvider.decrementQuantity(index),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  Text(
                    item.quantity.toString(),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 16, color: AppColors.primary),
                    // DIUBAH: Memanggil fungsi dari provider
                    onPressed: () => cartProvider.incrementQuantity(index),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Promo Codes',
        prefixIcon: const Icon(Icons.local_offer_outlined, color: AppColors.primary),
        suffixIcon: TextButton(
          onPressed: () {},
          child: const Text('Apply',
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildPriceDetails(String label, String value,
      {bool isDiscount = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16,
                color: isTotal ? Colors.black : Colors.grey[600],
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                fontSize: 16,
                color: isDiscount
                    ? Colors.red
                    : (isTotal ? Colors.black : Colors.grey[800]),
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    // DIUBAH: Menggunakan Consumer agar UI otomatis update
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final discount = 2000.0;
        final total = cartProvider.subtotal - discount;
        final isSelectAll = cartProvider.items.isNotEmpty && cartProvider.items.every((item) => item.isSelected);

        return Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isSelectAll,
                    onChanged: (value) => cartProvider.toggleSelectAll(value ?? false),
                    activeColor: AppColors.primary,
                  ),
                  const Text('All Item', style: TextStyle(fontSize: 16)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage(totalPrice: total)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text('Checkout (${cartProvider.selectedItemsCount})',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        );
      },
    );
  }
}