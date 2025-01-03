import 'package:elo_clone/views/productDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get.dart';
import 'package:elo_clone/models/product.dart';

class productCard extends StatelessWidget {
  productCard({super.key, required this.product, required this.cart});

  final FlutterCart cart;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Material(
      //borderRadius: BorderRadius.circular(10),
      //elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(10), // Matches the card's corners
        onTap: () {
          Get.to(() => productDetailPage(product: product, cart: cart));
        },
        child: Card(
          margin: EdgeInsets.all(8),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Image.network(
                    product.productImage,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4),
                    // Product Price
                    Text(
                      '\Rs${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
