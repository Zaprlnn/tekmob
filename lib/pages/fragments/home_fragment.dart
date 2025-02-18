import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_constants.dart';
import 'package:flutter_ui_coffee_shop_2/models/coffee.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  String _category = AppConstants.categories.first;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        _buildHeader(),
        Gap(24),
        _buildSearch(),
        Gap(32),
        _buildCategories(),
        Gap(16),
        _buildMainCoffee(),
        Gap(35),
        _buildSpecialCoffee(),
        Gap(30),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 68, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning,',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.accentGrey,
                  ),
                ),
                Gap(10),
                Text(
                  'Leslie Alexander',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.darkActive,
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0, 5),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: Badge(
                smallSize: 10,
                backgroundColor: AppColors.accentWarning,
                child: ImageIcon(
                  AssetImage('assets/icons/bag-2.png'),
                  size: 24,
                  color: AppColors.darkActive,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, 5),
            child: IconButton(
              onPressed: () {},
              icon: Badge(
                smallSize: 10,
                backgroundColor: AppColors.accentWarning,
                child: ImageIcon(
                  AssetImage('assets/icons/message.png'),
                  size: 24,
                  color: AppColors.darkActive,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 56,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: UnconstrainedBox(
              child: ImageIcon(
                AssetImage('assets/icons/search-normal.png'),
                size: 20,
                color: AppColors.accentGrey,
              ),
            ),
            hintText: 'Search Product',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.accentGrey,
            ),
            suffixIcon: UnconstrainedBox(
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: IconButton.filled(
                  onPressed: () {},
                  constraints: BoxConstraints.tight(Size(32, 32)),
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
                  icon: ImageIcon(
                    AssetImage('assets/icons/setting-4.png'),
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.accentStroke,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.accentStroke,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 33,
      child: ListView.builder(
        itemCount: AppConstants.categories.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = AppConstants.categories[index];
          final isActive = item == _category;
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 24 : 8,
              right: index == AppConstants.categories.length - 1 ? 24 : 8,
            ),
            child: GestureDetector(
              onTap: () {
                _category = item;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: isActive ? AppColors.primary : Colors.transparent,
                  border: isActive
                      ? null
                      : Border.all(
                          color: AppColors.accentStroke,
                        ),
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

  Widget _buildMainCoffee() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: mainCoffees.map((e) {
          if (e == '') return Gap(16);
          final coffee = e as Coffee;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: coffee,
                );
              },
              child: _buildMainCoffeeItem(coffee),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMainCoffeeItem(Coffee coffee) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 20,
            color: Color(0xff001E14).withValues(alpha: 0.04),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: AppColors.accentContainer,
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              coffee.image,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          Gap(12),
          Text(
            coffee.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.darkActive,
            ),
          ),
          Gap(4),
          Text(
            coffee.type,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.accentGrey,
            ),
          ),
          Gap(16),
          if (coffee.newPrice == null)
            Text(
              NumberFormat.currency(
                decimalDigits: 2,
                locale: 'en_US',
                symbol: '\$',
              ).format(coffee.price),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.darkHover,
              ),
            ),
          if (coffee.newPrice != null)
            Row(
              children: [
                Text(
                  NumberFormat.currency(
                    decimalDigits: 2,
                    locale: 'en_US',
                    symbol: '\$',
                  ).format(coffee.newPrice),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.accentWarning,
                  ),
                ),
                Gap(4),
                Text(
                  '/was ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.accentGrey,
                  ),
                ),
                Text(
                  NumberFormat.currency(
                    decimalDigits: 2,
                    locale: 'en_US',
                    symbol: '\$',
                  ).format(coffee.price),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.accentGrey,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.accentGrey,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSpecialCoffee() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Special Offers',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.darkActive,
            ),
          ),
          ListView.builder(
            itemCount: specialCoffees.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final coffee = specialCoffees[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: coffee,
                  );
                },
                child: _buildSpecialCoffeeItem(coffee),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialCoffeeItem(Coffee coffee) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 20,
            color: Color(0xff001E14).withValues(alpha: 0.04),
          ),
        ],
      ),
      child: Row(
        children: [
          Material(
            color: AppColors.accentContainer,
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              coffee.image,
              width: 90,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),
          Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.darkActive,
                  ),
                ),
                Text(
                  coffee.type,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.accentGrey,
                  ),
                ),
                Gap(16),
                if (coffee.newPrice == null)
                  Text(
                    NumberFormat.currency(
                      decimalDigits: 2,
                      locale: 'en_US',
                      symbol: '\$',
                    ).format(coffee.price),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.darkHover,
                    ),
                  ),
                if (coffee.newPrice != null)
                  Row(
                    children: [
                      Text(
                        NumberFormat.currency(
                          decimalDigits: 2,
                          locale: 'en_US',
                          symbol: '\$',
                        ).format(coffee.newPrice),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.accentWarning,
                        ),
                      ),
                      Gap(4),
                      Text(
                        '/was ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.accentGrey,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                          decimalDigits: 2,
                          locale: 'en_US',
                          symbol: '\$',
                        ).format(coffee.price),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.accentGrey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.accentGrey,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
