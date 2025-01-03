import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get.dart';

import '../views/loginView.dart';

class LoginLoader extends StatefulWidget {
  final FlutterCart cart;

  const LoginLoader({super.key, required this.cart});

  @override
  State<LoginLoader> createState() => _LoginLoaderState();
}

class _LoginLoaderState extends State<LoginLoader> {
  @override
  void initState() {
    super.initState();
    _loadLoginPage();
  }

  Future<void> _loadLoginPage() async {
    await Future.delayed(const Duration(seconds: 2));
    await precacheImage(AssetImage('assets/background-img.jpg'), context);

    Get.to(loginView(cart: widget.cart,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
