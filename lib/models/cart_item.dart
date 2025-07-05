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

// Dummy data for cart items
final List<CartItem> myCart = [
  CartItem(
    coffeeId: 1,
    image: 'assets/images/1.png',
    name: 'Arabica Coffee',
    type: 'Light',
    size: '250g',
    price: 50000,
    quantity: 3,
    check: true,
  ),
  CartItem(
    coffeeId: 2,
    image: 'assets/images/2.png',
    name: 'Robusta Coffee',
    type: 'Medium',
    size: '100g',
    price: 45000,
    quantity: 1,
    check: false,
  ),
];
