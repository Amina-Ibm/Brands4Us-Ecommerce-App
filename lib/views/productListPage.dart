import 'package:elo_clone/controllers/apiProductController.dart';
import 'package:elo_clone/models/productCard.dart';
import 'package:elo_clone/views/CategoriesView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/cartController.dart';
import '../widgets/categoryButtons.dart';
import 'cartView.dart';

class productListpage extends StatelessWidget{
  productListpage({super.key, required this.cart});
  final FlutterCart cart;
  final TextEditingController searchController = TextEditingController();
  final apiProductController apiController = Get.find();
  void searchProducts(String value){
    if(value.isEmpty){
      //apiController.fetchProducts();
    }
    var filteredProducts = apiController.products
        .where((product) => product.title
        .toLowerCase()
        .contains(value.toLowerCase()))
        .toList();
        apiController.products.value = filteredProducts;
}
  final cartController cartControl = Get.find();
  Widget build(BuildContext context){
    Map<dynamic, dynamic> userDetails = apiController.userDetails;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Elo - Brands For Less',
        textAlign: TextAlign.center,),
          actions: [
          InkWell(
          onTap: () => Get.to( (() => CartView())),
    child: Obx( () {
    return  Badge(
    backgroundColor: Theme.of(context).colorScheme.secondary,
    label: Text(cartControl.getCartCount.toString()),
    child: const Icon(
    Icons.shopping_cart,

    ),
    );
    }

    )
    ),
    SizedBox(width: 10,)
    ],
      ),
      body:   Padding(padding: EdgeInsets.all(4),
        child:  Column(
          children: [
            SizedBox(height: 10,),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width - 50,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Text',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                  suffixIcon: InkWell(
                    onTap: (){
                      searchProducts(searchController.text);
                    },
                    child: Icon(Icons.search),
                  ) ,
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                  searchProducts(value);
              } ,),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                   categoryButtons(),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(CategoriesPage());
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 14, // Customize font size
                          color: Theme.of(context).colorScheme.secondary, // Customize text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 5,),
            Expanded(
              child: Obx( () {
                if(apiController.loadingProducts.value){
                  return Positioned.fill(
                      child: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),));
                }
                if(apiController.products.isEmpty){
                  return Center(
                      child: Lottie.asset(
                        'assets/no-search-item.json',
                        height: 200.0,
                        repeat: true,
                        reverse: true,
                        animate: true,
                      )
                  );
                }
                var productsList = apiController.products;
                return  GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                    mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 0.84,
                    ),
                    itemCount: productsList.length,
                    itemBuilder: (context, index ) {
                      final product = productsList[index];
                      return Hero(
                          tag: 'product-${product.productId}',
                          child: productCard(product: product, cart: cart));
                    });
              }
              ),
            ),
          ],
        )),
      )
    ;
  }
}