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
        //surfaceGrayColor
        decoration: BoxDecoration(color: Colors.transparent, borderRadius: .circular(NumberConstant.cardRadius),),
        child: Padding(
          padding: .all(NumberConstant.popularTilePadding),
          child: Row(
            spacing: NumberConstant.popularTileGap,
            children: [
              ClipRRect(
                borderRadius: .circular(NumberConstant.popularThumbRadius),
                child: ColoredBox(
                  //cardCreamColor
                  color: AppColors.cardCreamColor,
                  //product.image, widthHeight: popularThumbSize, fit.contain
                  child: const SizedBox()
                ),
              ),
              Expanded(
                child: Column(
                  spacing: NumberConstant.popularContentGap,
                  crossAxisAlignment: .start,
                  children: [
                    //product.name, productCardTitle, maxLines:2,
                    //product.volume, productVolume
                  ],
                ),
              ),
              //icArrowNext
            ],
          ),
        ),
      ),
    );
  }
}
