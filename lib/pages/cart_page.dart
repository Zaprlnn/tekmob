import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:flutter_ui_coffee_shop_2/models/cart_item.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _allItem = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Gap(82),
          _buildAppbar(),
          _buildList(),
          Gap(24),
          _buildPromoCode(),
          Gap(24),
          _buildTotal(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: _buildCheckout(),
      ),
    );
  }

  Widget _buildAppbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton.filled(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AppColors.accentStroke,
              ),
            ),
            icon: ImageIcon(
              AssetImage('assets/icons/arrow-left.png'),
              size: 24,
              color: AppColors.darkActive,
            ),
          ),
          Text(
            'Detail Item',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.darkActive,
            ),
          ),
          IconButton(
            onPressed: null,
            icon: ImageIcon(
              AssetImage('assets/icons/message-question.png'),
              size: 24,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: myCart.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 20),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = myCart[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      AssetImage(
                        item.check
                            ? 'assets/icons/tick-square.png'
                            : 'assets/icons/square.png',
                      ),
                      size: 24,
                      color: AppColors.darkActive,
                    ),
                  ),
                  Gap(8),
                  Material(
                    color: AppColors.accentContainer,
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      item.image,
                      height: 88,
                      width: 88,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.darkActive,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              item.type,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.accentGrey,
                              ),
                            ),
                            Gap(8),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.accentText,
                              ),
                            ),
                            Gap(8),
                            Text(
                              item.size,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.accentGrey,
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Text(
                              NumberFormat.currency(
                                decimalDigits: 2,
                                locale: 'en_US',
                                symbol: '\$',
                              ).format(item.price),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.darkHover,
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.accentStroke,
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 10,
                                color: AppColors.accentGrey,
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 26,
                              decoration: BoxDecoration(
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: AppColors.accentStroke,
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${item.quantity}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColors.darkHover,
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.accentStroke,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 10,
                                color: AppColors.accentGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(16),
              Divider(
                indent: 16,
                endIndent: 24,
                height: 1.5,
                thickness: 1.5,
                color: AppColors.accentStroke,
              ),
              Gap(16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPromoCode() {
    return Container(
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFAFAFA),
      ),
      child: Row(
        children: [
          ImageIcon(
            AssetImage('assets/icons/discount-shape.png'),
            size: 24,
            color: AppColors.darkActive,
          ),
          Gap(8),
          Text(
            'Promo Codes',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.accentText,
            ),
          ),
          Spacer(),
          Text(
            'Apply',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotal() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(24),
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
        children: [
          _buildItems(
            'Items',
            NumberFormat.currency(
              decimalDigits: 2,
              symbol: '\$',
              locale: 'en_US',
            ).format(89.85),
          ),
          Gap(4),
          Divider(
            thickness: 1.5,
            height: 1.5,
            color: AppColors.accentStroke,
          ),
          Gap(8),
          _buildItems(
            'Discounts',
            NumberFormat.currency(
              decimalDigits: 2,
              symbol: '\$',
              locale: 'en_US',
            ).format(-9.80),
          ),
          Gap(4),
          Divider(
            thickness: 1.5,
            height: 1.5,
            color: AppColors.accentStroke,
          ),
          Gap(8),
          _buildItems('Delivery', 'Free'),
          Gap(4),
          Divider(
            thickness: 1.5,
            height: 1.5,
            color: AppColors.accentStroke,
          ),
          Gap(20),
          _buildItems(
            'Total',
            NumberFormat.currency(
              decimalDigits: 2,
              symbol: '\$',
              locale: 'en_US',
            ).format(80.05),
          ),
        ],
      ),
    );
  }

  Widget _buildItems(String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.accentText,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.darkHover,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 24, 24),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _allItem = !_allItem;
              setState(() {});
            },
            icon: ImageIcon(
              AssetImage(_allItem
                  ? 'assets/icons/tick-square.png'
                  : 'assets/icons/square.png'),
              size: 24,
              color: AppColors.darkActive,
            ),
          ),
          Text(
            'All Item',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.accentText,
            ),
          ),
          Spacer(),
          SizedBox(
            height: 56,
            child: FilledButton(
              onPressed: () {},
              child: Text(
                'Checkout (3)',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.light,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
