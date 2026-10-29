import 'package:flutter/material.dart';
import 'package:skincare_products_shopping_app/core/app_textstyles.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(productId, style: AppTextStyles.screenTitle,),),);
  }
}
