import 'package:elo_clone/main.dart';
import 'package:elo_clone/views/loginView.dart';
import 'package:elo_clone/views/mainPage.dart';
import 'package:elo_clone/views/productListPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Confirmed"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/order_confirm.json',
                height: 200.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),

              const SizedBox(height: 20),
              const Text(
                "Thank you for your purchase!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Your order has been successfully placed. You will receive a confirmation email shortly.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  final FlutterCart cart = FlutterCart();
                  cart.initializeCart(isPersistenceSupportEnabled: true);
                  Get.off( () => MainPage(cart: cart));
                },
                child: const Text("Continue Shopping"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
