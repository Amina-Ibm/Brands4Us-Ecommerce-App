import 'package:elo_clone/views/productDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get.dart';
import 'package:elo_clone/models/product.dart';

class productCard extends StatelessWidget{
  productCard({super.key, required this.product, required this.cart});
  final FlutterCart cart;
  final Product product;
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){Get.to(productDetailPage(product: product, cart: cart,)) ;} ,
      child: Card(

          margin: EdgeInsets.all(8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

           ClipRect(
              clipBehavior: Clip.hardEdge,
             child: Image(
                image: product.itemImage,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: 4),
              // Product Price
              Text(
              '\Rs${product.price.toStringAsFixed(2)}',
              style: TextStyle(
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.bold,
              ),
              ),
              ]
              )
              )
              ]
              )
      ),
    );
  }
  }