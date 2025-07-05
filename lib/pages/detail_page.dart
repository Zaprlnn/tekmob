import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/models/coffee.dart';
import 'package:flutter_ui_coffee_shop_2/pages/payment_page.dart';
import 'package:flutter_ui_coffee_shop_2/providers/cart_provider.dart';
import 'package:flutter_ui_coffee_shop_2/providers/favorites_provider.dart';
import 'package:flutter_ui_coffee_shop_2/providers/notification_provider.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.coffee});
  final Coffee coffee;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String _size;
  late String _levelSugar;
  late double _currentPrice;

  final List<String> _sugarLevels = ['No Sugar', 'Low', 'Medium'];

  @override
  void initState() {
    super.initState();
    _size = widget.coffee.sizes.isNotEmpty ? widget.coffee.sizes.first : 'Small';
    _levelSugar = 'Low';
    _updatePrice();
  }

  void _updatePrice() {
    double basePrice = (widget.coffee.newPrice ?? widget.coffee.price).toDouble();
    if (_size == 'Medium') {
      _currentPrice = basePrice + 2000;
    } else if (_size == 'Large') {
      _currentPrice = basePrice + 4000;
    } else {
      _currentPrice = basePrice;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildHeaderImage(),
          _buildTopButtons(),
          _buildProductDetails(),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildHeaderImage() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.asset(
          widget.coffee.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTopButtons() {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final isFavorite = favoritesProvider.isFavorite(widget.coffee);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon:
                      const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(179)),
                ),
                IconButton(
                  onPressed: () {
                    favoritesProvider.toggleFavorite(widget.coffee);
                    
                    final wasAdded = favoritesProvider.isFavorite(widget.coffee);
                    if (wasAdded) {
                      Provider.of<NotificationProvider>(context, listen: false).addNotification(
                        title: 'Added to Favorites',
                        message: '${widget.coffee.name} has been added to your favorites.',
                        image: widget.coffee.image,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFF00623B),
                          content: Text('${widget.coffee.name} ditambahkan ke favorit!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? const Color(0xFF00623B) : Colors.black,
                    size: 28,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(179)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductDetails() {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.55,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(24.0),
            children: [
              _buildProductTitleAndRating(),
              const Gap(24),
              _buildOptionSection(
                title: 'Cup Size',
                options: widget.coffee.sizes,
                selectedValue: _size,
                onChanged: (value) {
                  setState(() {
                    _size = value;
                    _updatePrice();
                  });
                },
              ),
              const Gap(24),
              _buildOptionSection(
                title: 'Level Sugar',
                options: _sugarLevels,
                selectedValue: _levelSugar,
                onChanged: (value) {
                  setState(() {
                    _levelSugar = value;
                  });
                },
              ),
              const Gap(24),
              _buildAboutSection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductTitleAndRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.coffee.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const Gap(4),
              Text(
                widget.coffee.type,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 24),
            const Gap(4),
            Text(
              '${widget.coffee.rating}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Text(
          widget.coffee.description,
          style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
        ),
      ],
    );
  }

  Widget _buildOptionSection({
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: options.map((option) {
            final bool isActive = option == selectedValue;
            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(option),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF00623B) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isActive ? const Color(0xFF00623B) : Colors.grey[300]!,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isActive ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    // DIUBAH: Mendapatkan kedua provider
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF0F0F0), width: 1.5),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF00623B),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Aksi 1: Tambah ke keranjang
                  cartProvider.addToCart(widget.coffee, _size, _levelSugar);
                  
                  // DIUBAH: Aksi 2: Tambahkan notifikasi ke provider
                  notificationProvider.addNotification(
                    title: 'Added to Cart',
                    message: '${widget.coffee.name} ($_size) has been added to your cart.',
                    image: widget.coffee.image
                  );
                  
                  // Aksi 3: Tampilkan notifikasi snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF00623B),
                      content: Text('${widget.coffee.name} ($_size) ditambahkan ke keranjang!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white, size: 28),
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: Colors.white.withAlpha(128),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(totalPrice: _currentPrice),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.transparent, 
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(_currentPrice),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}