import 'package:elo_clone/views/cartView.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:elo_clone/controllers/cartController.dart';
import 'package:get/get.dart';

class productDetailPage extends StatefulWidget{
  productDetailPage({super.key, required this.product, required this.cart});

  final Product product;
  final FlutterCart cart;

  @override
  State<productDetailPage> createState() => _productDetailPageState();
}

class _productDetailPageState extends State<productDetailPage> {
  String? selectedSize;
  Widget build(BuildContext context){

    final cartController cartControl = Get.put(cartController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail Page'),
        actions: [
          InkWell(
          onTap: () => Get.to(CartView()),
          child: Badge(
           backgroundColor: Colors.purpleAccent,
             label: Text(cartControl.getCartCount.toString()),
            child: const Icon(
              Icons.shopping_cart,

            ),
          ),
          )
        ],

      ),
      body: Padding(padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRect(
                clipBehavior: Clip.hardEdge,
                child: Image(
                  image: widget.product.itemImage,
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),
          ),
                Text(widget.product.title),
          SizedBox(height: 10,),
            Text(widget.product.category.toString().split('.').last),
            SizedBox(height: 10,),
          Text(widget.product.price.toStringAsFixed(2)),
            SizedBox(height: 10,),
          Text(widget.product.description),

              const Text("Select Size:", style: TextStyle(fontSize: 16)),
              DropdownButton<String>(
                  hint: selectedSize == null ? Text("Choose a size") : Text(selectedSize!),
                  items: widget.product.availableSizes.map((size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                 ;
                  },

                ),
              ElevatedButton(
                  onPressed: (){cartControl.addToCart(widget.product, selectedSize!);
                    Get.to(CartView());},
                  child: Text('Add to Cart'))
              ]),
        )

            ,
        ),
      )
    ;
  }
}