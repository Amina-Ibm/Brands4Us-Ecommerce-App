import 'package:elo_clone/widgets/loginLoader.dart';
import 'package:elo_clone/views/loginView.dart';
import 'package:elo_clone/views/mainPage.dart';
import 'package:elo_clone/views/onboardingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:elo_clone/views/productListPage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'controllers/apiProductController.dart';
import 'package:get/get.dart';

import 'controllers/cartController.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final FlutterCart cart = FlutterCart();
  cart.initializeCart(isPersistenceSupportEnabled: true);

  Get.put(apiProductController(), permanent: true);
  Get.put(cartController(), permanent: true);

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  Widget initialScreen;
  if (isLoggedIn) {
    initialScreen = MainPage(cart: cart,);
  } else {
    initialScreen = OnBoardingPage(cart: cart);
  }
  runApp(MainApp(initialScreen: initialScreen,));
  FlutterNativeSplash.remove();

}

class MainApp extends StatelessWidget {
   MainApp({super.key, required this.initialScreen });
  Widget initialScreen;
  @override
  build (BuildContext context) {
     var colorScheme =  ColorScheme.fromSeed(seedColor: Colors.blueAccent);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: colorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
            padding: EdgeInsets.symmetric(horizontal: 60)
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          displayLarge: TextStyle(
            letterSpacing: 1.1,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary
          ),
            bodyLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black
            ),
            displaySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorScheme.secondary
            ),
            displayMedium: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 20
            ),
            bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
                color: Colors.black
        ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: colorScheme.primary, // Selected item color
          unselectedItemColor: Colors.grey, // Unselected item color
        ),
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary
        ),
    ),
      //title: 'Elo Clone',
      home: initialScreen
    );
  }
}