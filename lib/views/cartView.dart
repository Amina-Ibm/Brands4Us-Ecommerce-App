import 'package:elo_clone/controllers/apiProductController.dart';
import 'package:elo_clone/widgets/pastOrdersView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cartController.dart';
import 'package:toastification/toastification.dart';
import 'package:elo_clone/views/orderConfirmPage.dart';
import 'package:lottie/lottie.dart';

class CartView extends StatelessWidget {
  CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController cartControl = Get.put(cartController());
    final apiProductController apiController = Get.find();

    Map<dynamic, dynamic> userDetails = apiController.userDetails;
    Future<void> getPastOrders() async {
      print(userDetails['id']);
      final userCart = await apiController.getUserCart(userDetails['id']);
      print(userCart);

      Get.to( (() => pastOrdersView()));
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        actions: [
          Obx(() => Badge(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: Text(cartControl.getCartCount.toString()),
            child: const Icon(
              Icons.shopping_cart,
            ),
          )),
          SizedBox(width: 10,),
        ],
      ),
      body: Obx(() {
        if (cartControl.getCartItems.isEmpty) {
          return Center(
            child: Lottie.asset(
                'assets/no_items_cart.json',
              height: 200.0,
              repeat: true,
              reverse: true,
              animate: true,
            )
          );
        }
        return ListView.builder(
          itemCount: cartControl.getCartItems.length,
          itemBuilder: (context, index) {
            final cartItem = cartControl.getCartItems[index];
            return Dismissible(
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog<bool>(
                    context: context,
                    builder: (ctx){
                      return AlertDialog(
                        elevation: 10,
                        surfaceTintColor: Theme.of(context).colorScheme.primary,
                        shadowColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.onPrimary,
                        title: Text('Delete item'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text('Do yu want to delete this item from cart?')
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: (){ Navigator.of(context).pop(true);}, child: Text('Yes')),
                          TextButton(onPressed: (){
                            Navigator.of(context).pop(false);}, child: Text('No'))
                        ],
                      );
                    });
              },
              onDismissed: (DismissDirection direction){
                cartControl.removeItemFromCart(cartItem);
              },
              key: UniqueKey(),
              child: ListTile(
                leading: Image.network(
                  cartItem.productImages![0],
                  scale: 0.5,
                  width: 40,
                ),
                title: Text(cartItem.productName,
                maxLines: 3,),
                subtitle: Row(
                  children: [
                    Text(
                      '\Rs${cartItem.variants[0].price.toString()}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 5,),
                    Text('Size: ${cartItem.variants[0].size}')
              
                  ],
                ),
              
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (cartItem.quantity > 1) {
                          cartControl.updateQuantity(cartItem, cartItem.quantity - 1);
                        } else {
                          cartControl.removeItemFromCart(cartItem);
                        }
                      },
                    ),
                    Text(
                      cartItem.quantity.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cartControl.updateQuantity(cartItem, cartItem.quantity + 1);
                      },
                    ),
              
                  ],
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \Rs${cartControl.subtotal.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  if (cartControl.getCartItems.isNotEmpty) {
                    Get.defaultDialog(
                      title: "Checkout",
                      content: Text(
                          "Total: \Rs${cartControl.getTotalAmount.toStringAsFixed(2)}"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.to( (() => OrderConfirmPage()));
                          },
                          child: Text("Confirm"),
                        ),
                      ],
                    );
                  } else {
                    toastification.show(
                      context: context,
                      type: ToastificationType.error,
                      style: ToastificationStyle.flatColored,
                      title: Text("No items in cart"),
                      description: Text("Add items to cart before checking out"),
                      alignment: Alignment.bottomCenter,
                      autoCloseDuration: const Duration(seconds: 4),
                      icon: Icon(Icons.shopping_cart),
                      boxShadow: lowModeShadow,
                    );
                  }
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

