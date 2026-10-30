import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skincare_products_shopping_app/constants/number_constant.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';
import 'package:skincare_products_shopping_app/core/app_motion.dart';

class CircleIconButton extends StatefulWidget {
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
  State<CircleIconButton> createState() => _CircleIconButtonState();
}

class _CircleIconButtonState extends State<CircleIconButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value || widget.onTap == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? AppMotion.pressScale : 1,
        duration: AppMotion.micro,
        curve: AppMotion.curve,
        child: DecoratedBox(
          decoration: BoxDecoration(color: widget.backgroundColor, shape: .circle),
          child: Padding(
            padding: widget.padding,
            child: SvgPicture.asset(widget.icon, colorFilter: .mode(widget.iconColor, .srcIn),),
          ),
        ),
      ),
    );
  }
}
