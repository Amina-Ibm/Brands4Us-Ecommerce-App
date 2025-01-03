import 'package:flutter/material.dart';

class Category {
  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage
});
  final int categoryId;
  final String categoryName;
  final NetworkImage categoryImage;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      categoryId: json['id'],
      categoryName: json['name'],
        categoryImage: json['image']
    );
  }
}


class Product {
  Product({
    required this.productId,
    required this.title,
    required this.productImage,
    required this.price,
    required this.category,
    required this.description,
    //this.availableSizes = const [],
  });
  final int productId;
  final String title;
  final String productImage;
  final double price;
  final String  category;
  final String description;
  //final List<String> availableSizes;


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      productImage: json['image']
      //productImages: List<NetworkImage>.from(json['images']),
    );
  }
}