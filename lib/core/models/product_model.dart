import 'package:flutter/material.dart';
import 'package:skincare_products_shopping_app/constants/string_const.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String volume;
  final String image;
  final Color backgroundColor;
  final String category;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.volume,
    required this.image,
    required this.backgroundColor,
    required this.category,
  });

  String get formattedPrice {
    final parts = price.toStringAsFixed(2).split('.');
    final whole = parts[0].replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');
    return '${StringConst.currencyPrefix}$whole.${parts[1]}';
  }
}
