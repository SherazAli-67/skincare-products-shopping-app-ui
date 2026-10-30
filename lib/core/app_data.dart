import 'package:skincare_products_shopping_app/constants/string_const.dart';
import 'package:skincare_products_shopping_app/core/app_colors.dart';
import 'package:skincare_products_shopping_app/core/asset_res.dart';
import 'package:skincare_products_shopping_app/core/models/product_model.dart';

class AppData {
  static const categories = [
    StringConst.categoryAll,
    StringConst.categorySerum,
    StringConst.categoryToner,
    StringConst.categoryFragrances,
    StringConst.categoryMoisturizers,
    StringConst.categoryCleansers,
  ];

  static const products = [
    ProductModel(
      id: '1',
      name: 'Tea Tree 3-in-1 Wash Scrub Mask',
      price: 8030,
      volume: '100ml',
      image: AssetRes.teeTreeProdImg,
      backgroundColor: AppColors.cardMintColor,
      category: StringConst.categoryCleansers,
    ),
    ProductModel(
      id: '2',
      name: 'Shea Shower Cream',
      price: 8030,
      volume: '250ml',
      image: AssetRes.sheaShowerProdImg,
      backgroundColor: AppColors.cardCreamColor,
      category: StringConst.categoryCleansers,
    ),
    ProductModel(
      id: '3',
      name: 'Breathe Massage Melt',
      price: 7730,
      volume: '100ml',
      image: AssetRes.breathMassageProdImg,
      backgroundColor: AppColors.cardSkyColor,
      category: StringConst.categoryMoisturizers,
    ),
    ProductModel(
      id: '4',
      name: 'Breathe Massage Melt',
      price: 7410,
      volume: '100ml',
      image: AssetRes.breathMassage2ProdImg,
      backgroundColor: AppColors.cardLavenderColor,
      category: StringConst.categoryMoisturizers,
    ),
    ProductModel(
      id: '5',
      name: 'Cherries & Cheer Body & Space Mist',
      price: 5950,
      volume: '100ml',
      image: AssetRes.cherriesCheerBodyProdImg,
      backgroundColor: AppColors.cardPinkColor,
      category: StringConst.categoryFragrances,
    ),
    ProductModel(
      id: '6',
      name: 'White Musk® Lover Eau De Parfum',
      price: 4950,
      volume: '100ml',
      image: AssetRes.whiteMuskProdImg,
      backgroundColor: AppColors.cardBeigeColor,
      category: StringConst.categoryFragrances,
    ),
  ];

  static ProductModel? productById(String id) {
    for (final product in products) {
      if (product.id == id) return product;
    }
    for (final product in popularProducts) {
      if (product.id == id) return product;
    }
    return null;
  }

  static const popularProducts = [
    ProductModel(
      id: '7',
      name: 'Vitamin C Glow Revealing Microdermabrasion',
      price: 8030,
      volume: '250ml',
      image: AssetRes.teeTreeProdImg,
      backgroundColor: AppColors.surfaceGrayColor,
      category: StringConst.categorySerum,
    ),
    ProductModel(
      id: '8',
      name: 'Vitamin C Glow Boosting Moisturiser',
      price: 8030,
      volume: '250ml',
      image: AssetRes.sheaShowerProdImg,
      backgroundColor: AppColors.surfaceGrayColor,
      category: StringConst.categoryMoisturizers,
    ),
    ProductModel(
      id: '9',
      name: 'Vitamin C Glow Revealing Liquid Peel',
      price: 7730,
      volume: '100ml',
      image: AssetRes.breathMassageProdImg,
      backgroundColor: AppColors.surfaceGrayColor,
      category: StringConst.categorySerum,
    ),
    ProductModel(
      id: '10',
      name: 'Vitamin E Moisture Day Cream',
      price: 7410,
      volume: '50-100ml',
      image: AssetRes.whiteMuskProdImg,
      backgroundColor: AppColors.surfaceGrayColor,
      category: StringConst.categoryMoisturizers,
    ),
  ];
}
