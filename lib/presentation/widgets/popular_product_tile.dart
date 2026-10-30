import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skincare_products_shopping_app/constants/number_constant.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';
import 'package:skincare_products_shopping_app/core/app_motion.dart';
import 'package:skincare_products_shopping_app/core/app_textstyles.dart';
import 'package:skincare_products_shopping_app/core/asset_res.dart';
import 'package:skincare_products_shopping_app/core/models/product_model.dart';

class PopularProductTile extends StatefulWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const PopularProductTile({super.key, required this.product, this.onTap});

  @override
  State<PopularProductTile> createState() => _PopularProductTileState();
}

class _PopularProductTileState extends State<PopularProductTile> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value || widget.onTap == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? AppMotion.pressScale : 1,
        duration: AppMotion.micro,
        curve: AppMotion.curve,
        child: DecoratedBox(
          decoration: BoxDecoration(color: AppColors.surfaceGrayColor, borderRadius: .circular(NumberConstant.cardRadius),),
          child: Padding(
            padding: .all(NumberConstant.popularTilePadding),
            child: Row(
              spacing: NumberConstant.popularTileGap,
              children: [
                ClipRRect(
                  borderRadius: .circular(NumberConstant.popularThumbRadius),
                  child: ColoredBox(
                    color: AppColors.cardCreamColor,
                    child: Image.asset(
                      widget.product.image,
                      width: NumberConstant.popularThumbSize,
                      height: NumberConstant.popularThumbSize,
                      fit: .contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: NumberConstant.popularContentGap,
                    crossAxisAlignment: .start,
                    children: [
                      Text(widget.product.name, style: AppTextStyles.productCardTitle,),
                      Text(widget.product.volume, style: AppTextStyles.productVolume,),
                    ],
                  ),
                ),
                AnimatedSlide(
                  offset: _pressed ? const Offset(0.15, 0) : Offset.zero,
                  duration: AppMotion.micro,
                  curve: AppMotion.curve,
                  child: SvgPicture.asset(AssetRes.icArrowNext),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
