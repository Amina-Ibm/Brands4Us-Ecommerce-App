import 'package:elo_clone/controllers/productContoller.dart';
import 'package:elo_clone/models/productCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get.dart';

class productListpage extends StatelessWidget{
  productListpage({super.key, required this.cart});
  final FlutterCart cart;
  final productController productDatabaseController = Get.put(productController());
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List Page'),
      ),
      body: Padding(padding: EdgeInsets.all(10),
        child: Obx( () {
          var productsList = productDatabaseController.products;
          return GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
              mainAxisSpacing: 5,
                crossAxisSpacing: 1.5,
                childAspectRatio: 0.5,

              ),
              itemCount: productsList.length,
              itemBuilder: (context, index ) {
                final product = productsList[index];
                return productCard(product: product, cart: cart,);

              });

        }

        )),
      )
    ;
  }
}