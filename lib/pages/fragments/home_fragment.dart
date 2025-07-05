import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:flutter_ui_coffee_shop_2/models/coffee.dart';
import 'package:flutter_ui_coffee_shop_2/pages/cart_page.dart'; // DIUBAH: Import halaman keranjang
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class HomeFragment extends StatefulWidget {
  final VoidCallback? onProfileTap;
  const HomeFragment({super.key, this.onProfileTap});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  String _category = "All Coffees";

  final List<Coffee> mainCoffees = [
    Coffee(
      id: 1,
      image: 'assets/images/kopi1.png',
      name: 'Expresso',
      type: 'Arabica Coffee',
      rating: 4.9,
      description: 'The fourth type of coffee drink is the Americano...',
      sizes: ['Small', 'Medium', 'Large'],
      price: 15000,
    ),
    Coffee(
      id: 2,
      image: 'assets/images/kopi3.png',
      name: 'Cappucino Latte',
      type: 'Robusta Coffee',
      rating: 4.8,
      description: 'Sweet & bold taste.',
      sizes: ['Small', 'Medium', 'Large'],
      price: 22000,
      newPrice: 20000,
    ),
    Coffee(
      id: 5,
      image: 'assets/images/kopi2.png',
      name: 'Mochacino',
      type: 'Robusta Coffee',
      rating: 4.7,
      description: 'Rich chocolate and coffee flavor.',
      sizes: ['Small', 'Medium', 'Large'],
      price: 20000,
    ),
  ];

  final List<Coffee> nonCoffees = [
    Coffee(
      id: 3,
      image: 'assets/images/matcha.png',
      name: 'Matcha Latte',
      type: 'Matcha Original',
      rating: 4.5,
      description: 'Rich and creamy.',
      sizes: ['Small', 'Medium', 'Large'],
      price: 25000,
      newPrice: 23000,
    ),
    Coffee(
      id: 4,
      image: 'assets/images/redvelvet.png',
      name: 'Red Velvet Latte',
      type: 'Red Velvet',
      rating: 4.5,
      description: 'Smooth with caramel hints.',
      sizes: ['Small', 'Medium', 'Large'],
      price: 25000,
      newPrice: 23000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const Gap(24),
          _buildSearch(),
          const Gap(32),
          _buildCategories(),
          const Gap(16),
          if (_category == "Original") ...[
            _buildCoffeeList(mainCoffees, title: 'Original'),
          ] else if (_category == "Non-Coffees") ...[
            _buildCoffeeList(nonCoffees, title: 'Non-Coffees'),
          ] else ...[
            _buildCoffeeList(mainCoffees, title: 'Original'),
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Special Offers',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.darkActive,
                ),
              ),
            ),
            const Gap(16),
            _buildCoffeeList(nonCoffees, title: 'Non-Coffees'),
          ],
          const Gap(30),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 68, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good Morning,',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.accentGrey),
                ),
                Gap(10),
                Text(
                  'Zaprlnnn',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: AppColors.darkActive),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // DIUBAH: Menambahkan GestureDetector agar ikon bisa di-klik
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                child: Stack(
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 28),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints:
                            const BoxConstraints(minWidth: 12, minHeight: 12),
                        child: const Text(
                          '2', // Contoh jumlah item
                          style: TextStyle(color: Colors.white, fontSize: 8),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  radius: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: AppColors.accentGrey),
          hintText: 'Search Product',
          hintStyle: const TextStyle(fontSize: 14, color: AppColors.accentGrey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.accentStroke),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.accentStroke),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const ImageIcon(
              AssetImage('assets/icons/setting-4.png'),
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final List<String> categories = ["All Coffees", "Original", "Non-Coffees"];
    return SizedBox(
      height: 33,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemBuilder: (context, index) {
          final item = categories[index];
          final isActive = item == _category;
          return Padding(
            padding:
                EdgeInsets.only(right: index == categories.length - 1 ? 0 : 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _category = item;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: isActive
                      ? null
                      : Border.all(color: AppColors.accentStroke),
                ),
                alignment: Alignment.center,
                child: Text(
                  item,
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 14,
                    color: isActive ? AppColors.light : AppColors.darkActive,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoffeeList(List<Coffee> coffeeList, {required String title}) {
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: coffeeList.map((coffee) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detail', arguments: coffee);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        coffee.image,
                        width: 90,
                        height: 76,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(coffee.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white)),
                          const Gap(4),
                          Text(coffee.type,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white70)),
                          const Gap(8),
                          if (coffee.newPrice != null)
                            Row(
                              children: [
                                Text(
                                  format.format(coffee.newPrice!),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "/ was ${format.format(coffee.price)}",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white70),
                                ),
                              ],
                            )
                          else
                            Text(
                              format.format(coffee.price),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}