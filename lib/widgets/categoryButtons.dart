import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elo_clone/controllers/apiProductController.dart';

class categoryButtons extends StatefulWidget {
  @override
  State<categoryButtons> createState() => _categoryButtonsState();
}

class _categoryButtonsState extends State<categoryButtons> {
  final apiProductController productController = Get.find();

  void setCategory(String? value){
    if(value == 'All'){
      productController.fetchProducts();
    } else if(value == null){
      productController.fetchProducts();
    }
    else{
      productController.selectedCategory.value = value!;
      productController.fetchProducts(category: value);
    }

  }

  var selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final categories = {'All', ...productController.categories}.toList();
    final limitedCategories = categories.take(3).toList();
    return Obx(() {
      if (productController.loadingCategories.value) {
        return Positioned.fill(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Row(
        children: [
          Choice<String>.inline(
            clearable: true,
            value: ChoiceSingle.value(selectedCategory),
            onChanged: ChoiceSingle.onChanged(setCategory),
            itemCount: limitedCategories.length,
            itemBuilder: (state, i) {
              return ChoiceChip(
                selected: state.selected(limitedCategories[i]),
                onSelected: state.onSelected(limitedCategories[i]),
                label: Text(limitedCategories[i]),
              );
            },
            listBuilder: ChoiceList.createScrollable(
              spacing: 5,
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 1,
              ),
            ),
          ),
        ],
      );
    });
  }
}
