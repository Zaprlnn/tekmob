class Coffee {
  Coffee({
    required this.id,
    required this.image,
    required this.name,
    required this.type,
    required this.rating,
    required this.description,
    required this.sizes,
    required this.price,
    this.newPrice,
  });

  final int id;
  final String image;
  final String name;
  final String type;
  final double rating;
  final String description;
  final List<String> sizes;
  final double price;
  final double? newPrice;
}

final mainCoffees = [
  Coffee(
    id: 1,
    image: 'assets/images/kopi1.png',
    name: 'Arabica Coffe',
    type: 'Light Roast',
    rating: 4.9,
    description:
        'Made by an expert farmer with an innovative fermentation process, resulting in sweet candied flavours. Darkly colored, bitter, and slightly acidic, coffee has a stimulating effect on humans, primarily due to its caffeine content. It has the highest sales in the world market for hot drinks. Decaffeinated coffee is also commercially available.',
    sizes: ['100g', '250g', '500g', '1kg'],
    price: 50000,
  ),
  '',
  Coffee(
    id: 2,
    image: 'assets/images/kopi2.png',
    name: 'Robusta Coffe',
    type: 'Medium Roast',
    rating: 4.8,
    description:
        'Made by an expert farmer with an innovative fermentation process, resulting in sweet candied flavours. Darkly colored, bitter, and slightly acidic, coffee has a stimulating effect on humans, primarily due to its caffeine content. It has the highest sales in the world market for hot drinks. Decaffeinated coffee is also commercially available.',
    sizes: ['100g', '250g', '500g', '1kg'],
    price: 60000,
    newPrice: 45000,
  ),
];

final specialCoffees = [
  Coffee(
    id: 3,
    image: 'assets/images/kopi3.png',
    name: 'Cappucino',
    type: 'Dark Roast',
    rating: 4.5,
    description:
        'Made by an expert farmer with an innovative fermentation process, resulting in sweet candied flavours. Darkly colored, bitter, and slightly acidic, coffee has a stimulating effect on humans, primarily due to its caffeine content. It has the highest sales in the world market for hot drinks. Decaffeinated coffee is also commercially available.',
    sizes: ['100g', '250g', '500g', '1kg'],
    price: 50000,
    newPrice: 40000,
  ),
  Coffee(
    id: 4,
    image: 'assets/images/4.png',
    name: 'Americano',
    type: 'Medium Dark Roast',
    rating: 4.5,
    description:
        'Made by an expert farmer with an innovative fermentation process, resulting in sweet candied flavours. Darkly colored, bitter, and slightly acidic, coffee has a stimulating effect on humans, primarily due to its caffeine content. It has the highest sales in the world market for hot drinks. Decaffeinated coffee is also commercially available.',
    sizes: ['100g', '250g', '500g', '1kg'],
    price: 30000,
  ),
];
