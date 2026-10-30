import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skincare_products_shopping_app/constants/number_constant.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';
import 'package:skincare_products_shopping_app/core/app_textstyles.dart';
import 'package:skincare_products_shopping_app/core/asset_res.dart';
import 'package:skincare_products_shopping_app/core/models/product_model.dart';
import 'package:skincare_products_shopping_app/presentation/widgets/circle_icon_button.dart';

class ProductOfferCard extends StatelessWidget {
  final ProductModel product;
  final Color actionColor;
  final Color actionIconColor;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;
  final double? width;
  final double? height;

  const ProductOfferCard({
    super.key,
    required this.product,
    this.actionColor = AppColors.primaryGreenColor,
    this.actionIconColor = AppColors.whiteColor,
    this.onTap,
    this.onActionTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: .all(NumberConstant.offerCardPadding),
        // decoration: BoxDecoration(color: product.backgroundColor, borderRadius: .circular(NumberConstant.cardRadius),),
        child: Column(
          spacing: NumberConstant.offerCardFooterGap,
          children: [
            Expanded(
              child: Column(
                spacing: NumberConstant.offerCardInnerGap,
                crossAxisAlignment: .stretch,
                children: [
                  //product.name, productCardTitle, maxLines: 2,
                  //img: product.image, fit.contain
                  Expanded(child: const SizedBox()),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: .circular(NumberConstant.pillRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: NumberConstant.frostBlur, sigmaY: NumberConstant.frostBlur),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    // color: AppColors.frostWhiteColor,
                    // borderRadius: .circular(NumberConstant.pillRadius),
                    // border: .all(color: AppColors.frostBorderColor),
                  ),
                  child: Padding(
                    padding: .only(
                      left: NumberConstant.pricePillHorizontalPadding,
                      top: NumberConstant.pricePillVerticalPadding,
                      bottom: NumberConstant.pricePillVerticalPadding,
                      right: NumberConstant.pricePillTrailingPadding,
                    ),
                    child: Row(
                      spacing: NumberConstant.categoryChipGap,
                      children: [
                        //product.formattedPrice, productPrice, maxLines: 1
                        Expanded(child: const SizedBox()),
                       /* CircleIconButton(
                          icon: AssetRes.icArrowNext,
                          onTap: onActionTap ?? onTap,
                          backgroundColor: actionColor,
                          iconColor: actionIconColor,
                          padding: .all(NumberConstant.smallCircleButtonPadding),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
