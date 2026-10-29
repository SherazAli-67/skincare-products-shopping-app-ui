import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skincare_products_shopping_app/constants/number_constant.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';
import 'package:skincare_products_shopping_app/core/app_textstyles.dart';
import 'package:skincare_products_shopping_app/core/asset_res.dart';
import 'package:skincare_products_shopping_app/core/models/product_model.dart';

class PopularProductTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const PopularProductTile({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  color: AppColors.whiteColor,
                  child: Image.asset(product.image, width: NumberConstant.popularThumbSize, height: NumberConstant.popularThumbSize, fit: .contain,),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: NumberConstant.popularContentGap,
                  crossAxisAlignment: .start,
                  children: [
                    Text(product.name, style: AppTextStyles.productCardTitle, maxLines: 2, overflow: .ellipsis,),
                    Text(product.volume, style: AppTextStyles.productVolume,),
                  ],
                ),
              ),
              SvgPicture.asset(AssetRes.icArrowNext, colorFilter: .mode(AppColors.blackColor, .srcIn),),
            ],
          ),
        ),
      ),
    );
  }
}
