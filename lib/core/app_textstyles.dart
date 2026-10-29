import 'package:flutter/material.dart';
import 'package:skincare_products_shopping_app/constants/string_const.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';

class AppTextStyles {
  static const greeting = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.secondaryTextColor,
  );

  static const userName = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: AppColors.primaryTextColor,
  );

  static const screenTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: AppColors.primaryTextColor,
  );

  static const sectionTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.blackColor,
  );

  static const viewAll = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.secondaryTextColor,
  );

  static const categorySelected = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.categorySelectedColor,
  );

  static const categoryUnselected = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.categoryUnselectedColor,
  );

  static const productCardTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 18 / 16,
    color: AppColors.productTitleColor,
  );

  static const productPrice = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColors.productTitleColor,
  );

  static const productDetailPrice = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.productTitleColor,
  );

  static const productVolume = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.secondaryTextColor,
  );

  static const productDetailVolume = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.secondaryTextColor,
  );

  static const searchHint = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.secondaryTextColor,
  );

  static const quantity = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 20 / 24,
    color: AppColors.blackColor,
  );

  static const swipeHint = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: AppColors.blackColor,
  );
}
