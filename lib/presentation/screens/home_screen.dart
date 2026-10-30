import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skincare_products_shopping_app/constants/number_constant.dart';
import 'package:skincare_products_shopping_app/constants/string_const.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';
import 'package:skincare_products_shopping_app/core/app_data.dart';
import 'package:skincare_products_shopping_app/core/app_motion.dart';
import 'package:skincare_products_shopping_app/core/app_textstyles.dart';
import 'package:skincare_products_shopping_app/core/asset_res.dart';
import 'package:skincare_products_shopping_app/core/models/product_model.dart';
import 'package:skincare_products_shopping_app/presentation/widgets/circle_icon_button.dart';
import 'package:skincare_products_shopping_app/presentation/widgets/popular_product_tile.dart';
import 'package:skincare_products_shopping_app/presentation/widgets/product_offer_card.dart';
import 'package:skincare_products_shopping_app/routing/router.dart';

class HomeCategoryProvider extends ChangeNotifier {
  String _selectedCategory = StringConst.categoryAll;

  String get selectedCategory => _selectedCategory;

  List<ProductModel> get filteredProducts =>
      _selectedCategory == StringConst.categoryAll
          ? AppData.products
          : AppData.products.where((product) => product.category == _selectedCategory).toList();

  void selectCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeCategoryProvider(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.contentGap, NumberConstant.horizontalPadding, 0),
            child: Column(
              spacing: NumberConstant.sectionGap,
              children: [
                _buildHeader(context),
                const _CategoryList(),
                SizedBox(height: NumberConstant.offerCardHeight, child: const _OfferCarousel(),),
                Expanded(child: _buildPopularSection(context),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      spacing: NumberConstant.headerGap,
      children: [
        Expanded(
          child: Row(
            spacing: NumberConstant.headerGap,
            children: [
              ClipOval(
                child: Image.asset(AssetRes.userAvatarImg, width: NumberConstant.avatarSize, height: NumberConstant.avatarSize, fit: .cover,),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(StringConst.goodMorning, style: AppTextStyles.greeting,),
                    Text(StringConst.userName, style: AppTextStyles.userName,),
                  ],
                ),
              ),
            ],
          ),
        ),
        CircleIconButton(icon: AssetRes.icSearch, onTap: () => context.go(NamedRoutes.explore.routeName),),
      ],
    );
  }

  Widget _buildPopularSection(BuildContext context) {
    return Column(
      spacing: NumberConstant.contentGap,
      children: [
        Row(
          children: [
            Expanded(child: Text(StringConst.popularProduct, style: AppTextStyles.sectionTitle,)),
            GestureDetector(
              onTap: () => context.go(NamedRoutes.explore.routeName),
              child: Text(StringConst.viewAll, style: AppTextStyles.viewAll,),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            padding: .only(bottom: NumberConstant.bottomNavClearance),
            itemCount: AppData.popularProducts.length,
            separatorBuilder: (_, _) => const SizedBox(height: NumberConstant.contentGap),
            itemBuilder: (context, index) {
              final product = AppData.popularProducts[index];
              return StaggeredFadeSlide(
                index: index,
                child: PopularProductTile(
                  product: product,
                  onTap: () => context.push(NamedRoutes.productDetails(product.id)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeCategoryProvider>();
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: NumberConstant.cardGap,
        children: AppData.categories.map((category) {
          final isSelected = provider.selectedCategory == category;
          return GestureDetector(
            onTap: () => provider.selectCategory(category),
            behavior: .opaque,
            child: Row(
              spacing: NumberConstant.categoryChipGap,
              children: [
                SizedBox(
                  width: NumberConstant.categoryDotSize,
                  height: NumberConstant.categoryDotSize,
                  child: AnimatedScale(
                    scale: isSelected ? 1 : 0.4,
                    duration: AppMotion.micro,
                    curve: AppMotion.curve,
                    child: AnimatedOpacity(
                      opacity: isSelected ? 1 : 0,
                      duration: AppMotion.micro,
                      curve: AppMotion.curve,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.primaryGreenColor, shape: .circle),
                        child: SizedBox.expand(),
                      ),
                    ),
                  ),
                ),
                AnimatedDefaultTextStyle(
                  duration: AppMotion.micro,
                  curve: AppMotion.curve,
                  style: isSelected ? AppTextStyles.categorySelected : AppTextStyles.categoryUnselected,
                  child: Text(category),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _OfferCarousel extends StatelessWidget {
  const _OfferCarousel();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeCategoryProvider>();
    final products = provider.filteredProducts;
    if (products.isEmpty) return const SizedBox.shrink();

    return AnimatedSwitcher(
      duration: AppMotion.medium,
      switchInCurve: AppMotion.curve,
      switchOutCurve: AppMotion.curve,
      transitionBuilder: (child, animation) {
        final offset = Tween<Offset>(begin: const Offset(0.04, 0), end: Offset.zero).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: offset, child: child),
        );
      },
      child: _OfferCarouselList(
        key: ValueKey(provider.selectedCategory),
        products: products,
      ),
    );
  }
}

class _OfferCarouselList extends StatefulWidget {
  final List<ProductModel> products;

  const _OfferCarouselList({super.key, required this.products});

  @override
  State<_OfferCarouselList> createState() => _OfferCarouselListState();
}

class _OfferCarouselListState extends State<_OfferCarouselList> {
  late final ScrollController _scrollController;

  static const _itemExtent = NumberConstant.offerCardWidth + NumberConstant.cardGap;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  double _scaleForIndex(int index) {
    if (!_scrollController.hasClients) {
      return index == 0 ? 1 : AppMotion.carouselIdleScale;
    }
    final distance = (index * _itemExtent - _scrollController.offset).abs();
    final t = (distance / NumberConstant.offerCardWidth).clamp(0.0, 1.0);
    return 1 - (t * (1 - AppMotion.carouselIdleScale));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      scrollDirection: .horizontal,
      itemCount: widget.products.length,
      separatorBuilder: (_, _) => const SizedBox(width: NumberConstant.cardGap),
      itemBuilder: (context, index) {
        final product = widget.products[index];
        final useGreenAction = index < 2;
        return Transform.scale(
          scale: _scaleForIndex(index),
          alignment: .center,
          child: ProductOfferCard(
            product: product,
            width: NumberConstant.offerCardWidth,
            height: NumberConstant.offerCardHeight,
            actionColor: useGreenAction ? AppColors.primaryGreenColor : AppColors.blackColor,
            onTap: () => context.push(NamedRoutes.productDetails(product.id)),
          ),
        );
      },
    );
  }
}
