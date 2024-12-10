import 'package:flutter/material.dart';

enum Category {
  tshirt,
  dress,
  jacket,
  hoodie,
  shoes,
}


class Product {
  Product({
    this.productId,
    required this.title,
    required this.itemImage,
    required this.price,
    required this.category,
    required this.description,
    this.availableSizes = const [],
  });
  final int? productId;
  final String title;
  final NetworkImage itemImage;
  final double price;
  final Category category;
  final String description;
  final List<String> availableSizes;
}