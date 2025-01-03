import 'package:elo_clone/controllers/cartController.dart';
import 'package:elo_clone/widgets/faqSection.dart';
import 'package:elo_clone/widgets/infoContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/apiProductController.dart';
import '../widgets/loginLoader.dart';

class HalfPageGradient extends StatefulWidget {
  HalfPageGradient({super.key, required this.cart});
  final FlutterCart cart;
  @override
  State<HalfPageGradient> createState() => _HalfPageGradientState();
}

class _HalfPageGradientState extends State<HalfPageGradient> {
  final apiProductController apiController = Get.find();
  final cartController cart = Get.find();
  late final user;
  int? previousOrders;
  @override
  void initState() {
    super.initState();
    user = apiController.userDetails;
    _fetchPreviousOrders();
  }
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(() => LoginLoader(cart: widget.cart));
  }
  Future<void> _fetchPreviousOrders() async {
    final userId = user['id'];
    final userCart = await apiController.getUserCart(userId);
    setState(() {
      previousOrders =
          userCart.length; // Update the state with the number of orders
    });
  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
                _logout(); // Perform logout
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 70,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            foregroundImage: NetworkImage('https://avatar.iran.liara.run/public'),
                            radius: 30,
                          ),
                          SizedBox(width: 20,),
                          Text('${user['firstname']} ${user['lastname']}'.toUpperCase(),
                          style: Theme.of(context).textTheme.displayMedium,),
                          Spacer(),
                          TextButton(onPressed: (){_showLogoutDialog(context);}, child: Text('Log Out',),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, // Text color
                            side: BorderSide(color: Colors.white, width: 2),
                          )
                          )
        
                        ],
        
                      ),
                    )
                  ],
                ),
              ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First container
                infoContainer(infoText: '${cart.getCartCount}', infoCaption: 'Items in your cart'),
                SizedBox(width: 10), // Space between containers
                // Second container
                infoContainer(infoText: '$previousOrders', infoCaption: 'Previous Orders'),
              ],
            ),
            SizedBox(height: 40,),
            Text('FAQs', style: Theme.of(context).textTheme.displayLarge,),
            faqSection()
            ]
            ),
      )

    );
  }
}

