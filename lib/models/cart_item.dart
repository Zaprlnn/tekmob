class CartItem {
  CartItem({
    required this.coffeeId,
    required this.image,
    required this.name,
    required this.type,
    required this.size,
    required this.price,
    required this.quantity,
    this.check = true,
  });

  final int coffeeId;
  final String image;
  final String name;
  final String type;
  final String size;
  final double price;
  final int quantity;
  final bool check;
}

final myCart = [
  CartItem(
    coffeeId: 1,
    image: 'assets/images/1.png',
    name: 'El Paseo Espresso',
    type: 'Light',
    size: '250g',
    price: 89.85,
    quantity: 3,
  ),
  CartItem(
    coffeeId: 2,
    image: 'assets/images/2.png',
    name: 'Cafeína Pinhal',
    type: 'Medium',
    size: '100g',
    price: 9.95,
    quantity: 1,
    check: false,
  ),
];
