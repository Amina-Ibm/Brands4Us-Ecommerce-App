import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apiProductController.dart';


class CategoriesPage extends StatelessWidget {
  final apiProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Obx(() {
        if (productController.loadingCategories.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns in the grid
              crossAxisSpacing: 10, // Horizontal spacing
              mainAxisSpacing: 10, // Vertical spacing
              childAspectRatio: 3 / 4, // Aspect ratio of the grid items
            ),
            itemCount: productController.categories.length,
            itemBuilder: (context, index) {
              final category = productController.categories[index];
              return GestureDetector(
                onTap: () {
                  productController.selectedCategory.value = category;
                  productController.fetchProducts(category: category);
                  Navigator.pop(context);
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/${category.toLowerCase()}.png', // Path to category icon
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      Text(
                        category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
