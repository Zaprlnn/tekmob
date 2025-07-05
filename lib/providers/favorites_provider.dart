import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/models/coffee.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Coffee> _favoriteCoffees = [];
  List<Coffee> get favoriteCoffees => _favoriteCoffees;

  bool isFavorite(Coffee coffee) {
    return _favoriteCoffees.any((item) => item.id == coffee.id);
  }

  void toggleFavorite(Coffee coffee) {
    if (isFavorite(coffee)) {
      _favoriteCoffees.removeWhere((item) => item.id == coffee.id);
    } else {
      _favoriteCoffees.add(coffee);
    }
    notifyListeners();
  }
}