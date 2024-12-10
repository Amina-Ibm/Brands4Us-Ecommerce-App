import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cartController.dart';
import 'package:toastification/toastification.dart';
import 'package:elo_clone/views/orderConfirmPage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController cartControl = Get.put(cartController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        actions: [
          Obx(() => Badge(
            backgroundColor: Colors.purpleAccent,
            label: Text(cartControl.getCartCount.toString()),
            child: const Icon(
              Icons.shopping_cart,
            ),
          )),
        ],
      ),
      body: Obx(() {
        if (cartControl.getCartItems.isEmpty) {
          return Center(
            child: Text("Your cart is empty!"),
          );
        }
        return ListView.builder(
          itemCount: cartControl.getCartItems.length,
          itemBuilder: (context, index) {
            final cartItem = cartControl.getCartItems[index];
            return ListTile(
              leading: Image.network(
                cartItem.productImages![0],
                scale: 0.5,
              ),
              title: Text(cartItem.productName),
              subtitle: Row(
                children: [
                  Text(
                    '\Rs${cartItem.variants[0].price.toString()}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 3,),
                  Text(
                    'Size: ${cartItem.variants[0].size}',
                    style: TextStyle(fontSize: 16),
                  ),
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
                'Total: \Rs${cartControl.subtotal.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            Get.to(OrderConfirmPage());
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

