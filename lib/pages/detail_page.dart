import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:flutter_ui_coffee_shop_2/models/coffee.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.coffee});
  final Coffee coffee;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _images = List.generate(3, (index) => 'assets/images/${index + 1}.png');
  final _pageController = PageController();
  late String _size;

  double _getPrice() {
    if (widget.coffee.newPrice != null) return widget.coffee.newPrice!;
    return widget.coffee.price;
  }

  @override
  void initState() {
    _size = widget.coffee.sizes.first;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 24,
            right: 24,
            top: 82,
            child: Column(
              children: [
                _buildAppbar(),
                _buildImages(),
              ],
            ),
          ),
          Positioned(
            top: 450,
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildContent(),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(child: _buildPrice()),
    );
  }

  Widget _buildAppbar() {
    return Row(
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
        IconButton.filled(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColors.accentStroke,
            ),
          ),
          icon: ImageIcon(
            AssetImage('assets/icons/message-question.png'),
            size: 24,
            color: AppColors.darkActive,
          ),
        ),
      ],
    );
  }

  Widget _buildImages() {
    return SizedBox(
      height: 350,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _images.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = _images[index];
          return Transform.translate(
            offset: Offset(12, -40),
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
        color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.only(bottom: 100),
        children: [
          Gap(20),
          Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _images.length,
              effect: ExpandingDotsEffect(
                dotHeight: 6,
                dotWidth: 6,
                expansionFactor: 3,
                dotColor: AppColors.primary.withValues(alpha: 0.2),
                activeDotColor: AppColors.primary,
              ),
            ),
          ),
          Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.coffee.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: AppColors.darkActive,
                        ),
                      ),
                      Gap(4),
                      Text(
                        widget.coffee.type,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.accentGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.accent.withValues(alpha: 0.12),
                  ),
                  child: Row(
                    children: [
                      ImageIcon(
                        AssetImage('assets/icons/star-bold.png'),
                        size: 16,
                        color: AppColors.accent,
                      ),
                      Gap(4),
                      Text(
                        '${widget.coffee.rating}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(12),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 60),
            child: ReadMoreText(
              '${widget.coffee.description} Flutter is Google’s mobile UI open source framework to build high-quality.',
              trimMode: TrimMode.Length,
              trimLength: 100,
              trimCollapsedText: 'Readmore',
              trimExpandedText: 'Readless',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: AppColors.accentText,
              ),
              moreStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColors.primary,
              ),
              lessStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColors.primary,
              ),
            ),
          ),
          Gap(20),
          _buildPackSize(),
        ],
      ),
    );
  }

  Widget _buildPackSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Pack Size',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        Gap(12),
        SizedBox(
          height: 33,
          child: ListView.builder(
            itemCount: widget.coffee.sizes.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.coffee.sizes[index];
              final isActive = item == _size;
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 24 : 8,
                  right: index == widget.coffee.sizes.length - 1 ? 24 : 8,
                ),
                child: GestureDetector(
                  onTap: () {
                    _size = item;
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
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.w400,
                        fontSize: 14,
                        color:
                            isActive ? AppColors.light : AppColors.darkActive,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price:',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.accentGrey,
                    ),
                  ),
                  Gap(4),
                  Text(
                    NumberFormat.currency(
                      decimalDigits: 2,
                      locale: 'en_US',
                      symbol: '\$',
                    ).format(_getPrice()),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: AppColors.darkHover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage('assets/icons/bag-2.png'),
                  size: 24,
                  color: Colors.white,
                ),
                label: Text(
                  'Add to Cart',
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
      ),
    );
  }
}
