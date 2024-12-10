import 'package:elo_clone/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class productController extends GetxController {
  var products = <Product>[].obs;
  List<Product> productList = [
    Product(
      title: "East West Women's Long Trench Coat",
      itemImage: NetworkImage("https://www.elo.shopping/cdn/shop/files/36_f03db0bb-9807-4d1b-b8bb-4f5c0aba2e70.jpg"),
      price: 4999,
      category: Category.jacket,
      description: "Elevate your outerwear game with the East West Women's Trench Coat, a timeless classic that combines style and functionality.",
      availableSizes: ['S', 'M', 'L']
    ),
    Product(
      title: "Safina Women's Angel Printed Hoodie",
      itemImage: NetworkImage('https://www.elo.shopping/cdn/shop/products/1_29a42edb-1a4f-4fd3-875a-ecaf0c36ac51.jpg'),
      price: 1519,
      category: Category.hoodie,
      description: "Safina Pullover hoodie is made of high-quality material, which is soft and comfortable to wear. The Hoodie is easy to match with any outfit and provides you a moderate warmth and comfort.",
        availableSizes: ['S', 'M', 'L']
    ),
    Product(
      title: "East West Women's Printed Maxi",
      itemImage: NetworkImage('https://www.elo.shopping/cdn/shop/files/DSC07441copy.jpg'),
      price: 1809,
      category: Category.dress,
      description: "Round neckline, Polka dot printed, Long flared maxi, Back slit",
        availableSizes: ['S', 'M', 'L']
    ),
    Product(
      title: "Mens Portsmouth Casual Sneakers",
      itemImage: NetworkImage('https://www.elo.shopping/cdn/shop/files/image-desc-6_54b5b0df-4e86-4071-a307-39bc94cc9551.jpg'),
      price: 3299,
      category: Category.shoes,
      description: "Elevate your streetwear game with these bold and fashionable sneakers. Designed to make a statement, they combine edgy aesthetics with everyday comfort. ",
        availableSizes: ['40', '41', '42', '43', '44' '45']
    ),
    Product(
      title: "Polo Republica Men's Loose Fit Tee",
      itemImage: NetworkImage('https://www.elo.shopping/cdn/shop/files/graphite2.jpg'),
      price: 499,
      category: Category.tshirt,
      description: "Perfect for lounging at home or exploring the city, this tee is your go-to for stylish, comfortable living. ",
        availableSizes: ['S', 'M', 'L']
    ),

  ];


  void onInit(){
    super.onInit();
    products.addAll(productList);
    initializeDatabase();
  }
  Future<void> initializeDatabase() async {
    final db = await _getDatabase();
    final data = await db.query('products');
      for (var product in productList) {
        await db.insert(
          'products',
          {
            'productTitle': product.title,
            'productImage': product.itemImage.url,
            'productPrice': product.price,
            'productCategory': product.category.name,
            'productDesc': product.description,
            'productSizes': product.availableSizes.join(',')
          },
        );
      }
    await loadProductsFromDatabase();
  }
  Future<sql.Database> _getDatabase() async {
    final dbpath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
        path.join(dbpath, 'ecommerce.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT, '
                  'productTitle TEXT,'
                  ' productImage TEXT, productPrice FLOAT,'
                  ' productCategory TEXT, productDesc TEXT,'
                  'productSizes TEXT');
        },
        version: 1
    );
    print("database connected");
    return db;
  }
  Future<void> loadProductsFromDatabase() async{
    final db = await _getDatabase();
    final data = await db.query('products');
    products.value =
        data.map(
                (product)  => Product(
                    productId: product['id'] as int,
                    title: product['productTitle'] as String,
                    itemImage: product['productImage'] as NetworkImage,
                    price: product['productPrice'] as double,
                    category: product['productCategory'] as Category,
                    description: product['productDesc'] as String,
                    availableSizes: (product['productSizes'] as String?)?.split(',') ?? []
                )
        ).toList();
  }
}