import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:skincare_products_shopping_app/routing/router.dart';

class ProductQuantityProvider extends ChangeNotifier {
  int _quantity = 1;
  int _direction = 1;

  int get quantity => _quantity;

  /// 1 when increasing, -1 when decreasing — drives quantity slide direction.
  int get direction => _direction;

  String get formattedQuantity => _quantity.toString().padLeft(2, '0');

  void increment() {
    _quantity += 1;
    _direction = 1;
    notifyListeners();
  }

  void decrement() {
    if (_quantity <= 1) return;
    _quantity -= 1;
    _direction = -1;
    notifyListeners();
  }
}

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = AppData.productById(productId);
    if (product == null) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Center(child: Text(StringConst.productNotFound, style: AppTextStyles.screenTitle,),),
      );
    }
    return ChangeNotifierProvider(
      create: (_) => ProductQuantityProvider(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withValues(alpha: 0.7),
              ],
              begin: .topCenter,
              end: .bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: .all(NumberConstant.horizontalPadding),
                  child: Stack(
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 224, sigmaY: 224),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white, product.backgroundColor],
                              begin: .topCenter,
                              end: .bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Hero(
                          tag: AppMotion.productHeroTag(product.id),
                          child: Image.asset(
                            product.image,
                            width: NumberConstant.productDetailImageWidth,
                            height: 450,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            const _QuantitySelector(),
                            _DetailsPanel(product: product),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: _DetailHeader(product: product),
                      ),
                    ],
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

class _DetailHeader extends StatefulWidget {
  final ProductModel product;

  const _DetailHeader({required this.product});

  @override
  State<_DetailHeader> createState() => _DetailHeaderState();
}

class _DetailHeaderState extends State<_DetailHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppMotion.medium);
    final curved = CurvedAnimation(parent: _controller, curve: AppMotion.curve);
    _fade = curved;
    _slide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(curved);
    Future<void>.delayed(const Duration(milliseconds: 120), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Column(
                spacing: NumberConstant.productDetailTitleGap,
                crossAxisAlignment: .start,
                children: [
                  Text(widget.product.name, style: AppTextStyles.productDetailTitle,),
                  Text(widget.product.volume, style: AppTextStyles.productDetailVolume,),
                ],
              ),
            ),
            CircleIconButton(icon: AssetRes.icArrowBack, onTap: () => context.pop(),),
          ],
        ),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductQuantityProvider>();
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        CircleIconButton(
          icon: AssetRes.icMinus,
          onTap: provider.decrement,
          backgroundColor: AppColors.transparentColor,
        ),
        AnimatedSwitcher(
          duration: AppMotion.micro,
          switchInCurve: AppMotion.curve,
          switchOutCurve: AppMotion.curve,
          transitionBuilder: (child, animation) {
            final offset = Tween<Offset>(
              begin: Offset(0, 0.35 * provider.direction),
              end: Offset.zero,
            ).animate(animation);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: offset, child: child),
            );
          },
          child: Text(
            provider.formattedQuantity,
            key: ValueKey(provider.quantity),
            style: AppTextStyles.quantity,
            textAlign: .center,
          ),
        ),
        CircleIconButton(
          icon: AssetRes.icPlus,
          onTap: provider.increment,
          backgroundColor: AppColors.transparentColor,
        ),
      ],
    );
  }
}

class _DetailsPanel extends StatefulWidget {
  final ProductModel product;

  const _DetailsPanel({required this.product});

  @override
  State<_DetailsPanel> createState() => _DetailsPanelState();
}

class _DetailsPanelState extends State<_DetailsPanel>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _nudgeController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<Offset> _nudge;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: AppMotion.page);
    final entranceCurved = CurvedAnimation(parent: _entranceController, curve: AppMotion.curve);
    _fade = entranceCurved;
    _slide = Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero).animate(entranceCurved);

    _nudgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _nudge = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.18)).animate(
      CurvedAnimation(parent: _nudgeController, curve: Curves.easeInOut),
    );

    Future<void>.delayed(const Duration(milliseconds: 220), () async {
      if (!mounted) return;
      await _entranceController.forward();
      if (!mounted) return;
      for (var i = 0; i < 3; i++) {
        await _nudgeController.forward();
        if (!mounted) return;
        await _nudgeController.reverse();
        if (!mounted) return;
      }
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _nudgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if ((details.primaryVelocity ?? 0) < 0) _showDetailsSheet(context);
          },
          onTap: () => _showDetailsSheet(context),
          child: ClipRRect(
            borderRadius: .circular(NumberConstant.detailsPanelRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: NumberConstant.productDetailPanelBlur,
                sigmaY: NumberConstant.productDetailPanelBlur,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.limePanelColor,
                  borderRadius: .circular(NumberConstant.detailsPanelRadius),
                  boxShadow: [
                    BoxShadow(color: AppColors.cartShadowColor, blurRadius: NumberConstant.navShadowBlur),
                  ],
                ),
                child: Padding(
                  padding: .only(top: NumberConstant.detailsPanelTopPadding),
                  child: Column(
                    spacing: NumberConstant.detailsPanelGap,
                    mainAxisSize: .min,
                    children: [
                      SlideTransition(
                        position: _nudge,
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AssetRes.icCaretDoubleUp,
                              colorFilter: .mode(AppColors.blackColor, .srcIn),
                            ),
                            Text(StringConst.swipeToMoreDetails, style: AppTextStyles.swipeHint,),
                          ],
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: .circular(NumberConstant.pillRadius),
                        ),
                        child: Padding(
                          padding: .only(
                            left: NumberConstant.addToCartBarLeadingPadding,
                            right: NumberConstant.addToCartBarTrailingPadding,
                            top: NumberConstant.addToCartBarVerticalPadding,
                            bottom: NumberConstant.addToCartBarVerticalPadding,
                          ),
                          child: Row(
                            spacing: NumberConstant.addToCartBarGap,
                            children: [
                              Expanded(
                                child: Text(widget.product.formattedPrice, style: AppTextStyles.productDetailPrice,),
                              ),
                              CircleIconButton(
                                icon: AssetRes.icCart,
                                onTap: () => context.go(NamedRoutes.cart.routeName),
                                backgroundColor: AppColors.blackColor,
                                iconColor: AppColors.whiteColor,
                                padding: .all(NumberConstant.filterButtonPadding),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDetailsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: NumberConstant.detailsSheetInitialSize,
        minChildSize: NumberConstant.detailsSheetMinSize,
        maxChildSize: NumberConstant.detailsSheetMaxSize,
        builder: (context, scrollController) => DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.limePanelColor,
            borderRadius: .vertical(top: .circular(NumberConstant.detailsPanelRadius)),
          ),
          child: ListView(
            controller: scrollController,
            padding: .all(NumberConstant.horizontalPadding),
            children: [
              Column(
                spacing: NumberConstant.contentGap,
                crossAxisAlignment: .start,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      AssetRes.icCaretDoubleUp,
                      colorFilter: .mode(AppColors.blackColor, .srcIn),
                    ),
                  ),
                  Text(StringConst.productDetailsTitle, style: AppTextStyles.sectionTitle,),
                  Text(widget.product.name, style: AppTextStyles.productCardTitle,),
                  Text(StringConst.productDetailsBody, style: AppTextStyles.productDetailVolume,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
