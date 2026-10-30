import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skincare_products_shopping_app/constants/number_constant.dart';
import 'package:skincare_products_shopping_app/constants/string_const.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';
import 'package:skincare_products_shopping_app/core/app_data.dart';
import 'package:skincare_products_shopping_app/core/app_textstyles.dart';
import 'package:skincare_products_shopping_app/core/asset_res.dart';
import 'package:skincare_products_shopping_app/core/models/product_model.dart';
import 'package:skincare_products_shopping_app/presentation/widgets/circle_icon_button.dart';
import 'package:skincare_products_shopping_app/presentation/widgets/product_offer_card.dart';
import 'package:skincare_products_shopping_app/routing/router.dart';

class ExploreSearchProvider extends ChangeNotifier {
  final searchController = TextEditingController();

  ExploreSearchProvider() {
    searchController.addListener(notifyListeners);
  }

  List<ProductModel> get filteredProducts {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) return AppData.products;
    return AppData.products.where((product) => product.name.toLowerCase().contains(query)).toList();
  }

  @override
  void dispose() {
    searchController.removeListener(notifyListeners);
    searchController.dispose();
    super.dispose();
  }
}

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExploreSearchProvider(),
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
                const _SearchBar(),
                const Expanded(child: _ProductGrid()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(StringConst.exploreProducts, style: AppTextStyles.screenTitle,),),
        CircleIconButton(icon: AssetRes.icArrowBack, onTap: () => context.go(NamedRoutes.home.routeName),),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ExploreSearchProvider>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceLightColor,
        borderRadius: .circular(NumberConstant.pillRadius),
        boxShadow: [BoxShadow(color: AppColors.searchInnerShadowColor, blurRadius: NumberConstant.frostBlur, blurStyle: .inner),],
      ),
      child: Padding(
        padding: .only(
          left: NumberConstant.searchBarLeadingPadding,
          right: NumberConstant.searchBarTrailingPadding,
          top: NumberConstant.searchBarVerticalPadding,
          bottom: NumberConstant.searchBarVerticalPadding,
        ),
        child: Row(
          spacing: NumberConstant.searchBarGap,
          children: [
            SvgPicture.asset(AssetRes.icSearch, colorFilter: .mode(AppColors.blackColor, .srcIn),),
            Expanded(
              child: TextField(
                controller: provider.searchController,
                style: AppTextStyles.searchHint.copyWith(color: AppColors.productTitleColor),
                cursorColor: AppColors.primaryGreenColor,
                decoration: InputDecoration(
                  isDense: true,
                  border: .none,
                  hintText: StringConst.searchProducts,
                  hintStyle: AppTextStyles.searchHint,
                  contentPadding: .zero,
                ),
              ),
            ),
            CircleIconButton(
              icon: AssetRes.icFilter,
              backgroundColor: AppColors.blackColor,
              iconColor: AppColors.whiteColor,
              padding: .all(NumberConstant.filterButtonPadding),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid();

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ExploreSearchProvider>().filteredProducts;
    return GridView.builder(
      padding: .only(bottom: NumberConstant.bottomNavClearance),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: NumberConstant.gridCrossAxisCount,
        crossAxisSpacing: NumberConstant.cardGap,
        mainAxisSpacing: NumberConstant.cardGap,
        mainAxisExtent: NumberConstant.gridCardHeight,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductOfferCard(
          product: product,
          width: double.infinity,
          height: NumberConstant.gridCardHeight,
          actionColor: AppColors.whiteColor,
          actionIconColor: AppColors.blackColor,
          onTap: () => context.push(NamedRoutes.productDetails(product.id)),
        );
      },
    );
  }
}
