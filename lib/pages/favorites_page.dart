import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:flutter_ui_coffee_shop_2/models/coffee.dart';
import 'package:flutter_ui_coffee_shop_2/pages/cart_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/payment_page.dart';
import 'package:flutter_ui_coffee_shop_2/providers/favorites_provider.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_hagia.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final favoriteItems = favoritesProvider.favoriteCoffees;

              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const Gap(24),
                    if (favoriteItems.isEmpty)
                      _buildEmptyFavorites()
                    else
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: favoriteItems.length,
                          itemBuilder: (context, index) {
                            final coffee = favoriteItems[index];
                            return Dismissible(
                              key: Key(coffee.id.toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                favoritesProvider.toggleFavorite(coffee);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${coffee.name} dihapus dari favorit.'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        favoritesProvider.toggleFavorite(coffee);
                                      },
                                    ),
                                  ),
                                );
                              },
                              background: _buildDismissibleBackground(),
                              child: _buildFavoriteItem(context, coffee),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 233, 233, 233),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Align(
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete_outline, color: Color.fromARGB(255, 20, 58, 5)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.search, color: Colors.white, size: 28),
                  const Gap(8),
                  Text(
                    'Good Vibes, Hagiaaa !!',
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  // DIHAPUS: Ikon notifikasi dan jaraknya sudah dihapus dari sini
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
                    },
                    child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 28),
                  ),
                  const Gap(16),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.png'),
                    radius: 16,
                  )
                ],
              ),
            ],
          ),
          const Gap(20),
          Text(
            'Favorites',
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Gap(4),
          Text(
            'Your favorite drinks to lighten up your day',
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, Coffee coffee) {
    final price = (coffee.newPrice ?? coffee.price).toDouble();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentPage(totalPrice: price)),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0E391F),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffee.type,
                      style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
                    ),
                    const Gap(4),
                    Text(
                      coffee.name.toUpperCase(),
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const Gap(12),
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.red, size: 18),
                        const Gap(6),
                        Text(
                          '240',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  coffee.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyFavorites() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.white.withAlpha(150)),
            const Gap(16),
            Text(
              'No Favorites Yet',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Text(
              "Tap the heart on any item\nto see it here.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}