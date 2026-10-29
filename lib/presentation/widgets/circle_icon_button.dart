import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skincare_products_shopping_app/constants/number_constant.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;
  final EdgeInsetsGeometry padding;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = AppColors.surfaceLightColor,
    this.iconColor = AppColors.blackColor,
    this.padding = const .all(NumberConstant.circleButtonPadding),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(color: backgroundColor, shape: .circle),
        child: Padding(
          padding: padding,
          child: SvgPicture.asset(icon, colorFilter: .mode(iconColor, .srcIn),),
        ),
      ),
    );
  }
}
