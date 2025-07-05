// lib/providers/cart_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/pages/cart_page.dart';
import 'package:flutter_ui_coffee_shop_2/models/coffee.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  // Getter untuk menghitung subtotal dari item yang dipilih
  double get subtotal {
    double total = 0;
    for (var item in _items) {
      if (item.isSelected) {
        total += item.price * item.quantity;
      }
    }
    return total;
  }

  // Getter untuk menghitung jumlah item yang dipilih
  int get selectedItemsCount {
    int count = 0;
    for (var item in _items) {
      if (item.isSelected) {
        count++;
      }
    }
    return count;
  }

  // Fungsi untuk menambah item ke keranjang
  void addToCart(Coffee coffee, String size, String sugarLevel) {
    int existingIndex = _items.indexWhere((item) =>
        item.name == coffee.name && item.details.contains(size));

    if (existingIndex != -1) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(
        name: coffee.name,
        image: coffee.image,
        details: '$size • 100g',
        price: (coffee.newPrice ?? coffee.price).toDouble(),
      ));
    }
    notifyListeners();
  }

  // Fungsi untuk mengubah status pilihan item
  void toggleItemSelection(int index, bool isSelected) {
    if (index >= 0 && index < _items.length) {
      _items[index].isSelected = isSelected;
      notifyListeners();
    }
  }

  // Fungsi untuk memilih atau batal memilih semua item
  void toggleSelectAll(bool selectAll) {
    for (var item in _items) {
      item.isSelected = selectAll;
    }
    notifyListeners();
  }

  // Fungsi untuk menambah kuantitas
  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  // Fungsi untuk mengurangi kuantitas
  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
        notifyListeners();
      }
    }
  }
}