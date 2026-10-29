import 'package:flutter/material.dart';
import 'package:skincare_products_shopping_app/constants/number_constant.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';
import 'package:skincare_products_shopping_app/core/asset_res.dart';
import 'package:skincare_products_shopping_app/presentation/widgets/circle_icon_button.dart';

class FloatingBottomNav extends StatelessWidget {
  static const homeIndex = 0;
  static const favoriteIndex = 1;
  static const cartIndex = 2;
  static const exploreIndex = 3;

  final int currentIndex;
  final ValueChanged<int> onTap;

  const FloatingBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: NumberConstant.navItemGap,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: .circular(NumberConstant.pillRadius),
            boxShadow: [BoxShadow(color: AppColors.navShadowColor, blurRadius: NumberConstant.navShadowBlur),],
          ),
          child: Padding(
            padding: .all(NumberConstant.navBarPadding),
            child: Row(
              spacing: NumberConstant.navIconGap,
              children: [
                _buildNavItem(index: homeIndex, icon: AssetRes.icHome),
                _buildNavItem(index: favoriteIndex, icon: AssetRes.icFavorite),
                _buildNavItem(index: cartIndex, icon: AssetRes.icCart),
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: .circular(NumberConstant.pillRadius),
            boxShadow: [BoxShadow(color: AppColors.navShadowColor, blurRadius: NumberConstant.navShadowBlur),],
          ),
          child: Padding(
            padding: .all(NumberConstant.navBarPadding),
            child: _buildNavItem(index: exploreIndex, icon: AssetRes.icExplore),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({required int index, required String icon}) {
    final isSelected = currentIndex == index;
    return CircleIconButton(
      icon: icon,
      onTap: () => onTap(index),
      backgroundColor: isSelected ? AppColors.blackColor : AppColors.surfaceGrayColor,
      iconColor: isSelected ? AppColors.whiteColor : AppColors.blackColor,
      padding: .all(NumberConstant.smallCircleButtonPadding),
    );
  }
}
