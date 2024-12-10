import 'package:elo_clone/views/onboardingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:elo_clone/views/productListPage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
  FlutterNativeSplash.remove();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  build (BuildContext context) {
      final FlutterCart cart = FlutterCart();
     cart.initializeCart(isPersistenceSupportEnabled: true);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Elo Clone',
      home: OnBoardingPage(cart: cart,)
    );
  }


}
