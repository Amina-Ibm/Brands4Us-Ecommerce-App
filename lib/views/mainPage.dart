import 'package:elo_clone/controllers/apiProductController.dart';
import 'package:elo_clone/views/CategoriesView.dart';
import 'package:elo_clone/views/ProfilePage.dart';
import 'package:elo_clone/views/orderDetails.dart';
import 'package:elo_clone/views/productListPage.dart';
import 'package:flutter_cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  final FlutterCart cart;
  MainPage({super.key, required this.cart});
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  final apiProductController apiController = Get.find();
  late SharedPreferences prefs;

  @override
  void initState()  {
    super.initState();
    _initialize();
    _pages = [
      productListpage(cart: widget.cart),
      CategoriesPage(),
      OrderDetails(),
      HalfPageGradient(cart: widget.cart,)
    ];
  }
  void getUserDetails(){
    final user = apiController.userDetails;
  }

  Future<void> _initialize() async {
    prefs = await SharedPreferences.getInstance();

    final username = prefs.getString('username');
    final password = prefs.getString('password');
    print(username);
    print(password);
    if (username != null && password != null) {
      await apiController.getUserDetails(username, password);
    }
  }

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _pages[_selectedIndex], // Display the selected page
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, // Highlight the selected tab
          onTap: _onItemTapped, // Handle tab selection
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
            label: 'Categories'),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      );
    }
  }

