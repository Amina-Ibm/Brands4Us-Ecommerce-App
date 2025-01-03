import 'package:elo_clone/controllers/apiProductController.dart';
import 'package:elo_clone/views/parstOrderDetailView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class pastOrdersView extends StatelessWidget {
  final apiProductController apiController = Get.find();
  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> userDetails = apiController.userDetails;
    return  FutureBuilder<List<Map<String, dynamic>>>
        (future: apiController.getUserCart(userDetails['id']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'),);
            }
            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No past orders found.'));
            }
            else {
              final userCart = snapshot.data!;
              return ListView.builder(
                itemCount: userCart.length,
                itemBuilder: (context, index) {
                  final cart = userCart[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12.0), // Rounded corners

                      ),
                      title: Text('Cart ID: ${cart['id']}',
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onPrimary
                        ),),
                      subtitle: Text('Date: ${cart['date']}',
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onPrimary
                        ),),
                      tileColor: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      onTap: () {
                        Get.to(() =>
                            pastOrderDetailView(
                                cart: cart));
                      },
                    ),
                  );
                },
              );
            }
          });
  }
}
