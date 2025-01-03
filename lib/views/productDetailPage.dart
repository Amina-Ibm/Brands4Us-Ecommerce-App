import 'package:elo_clone/controllers/apiProductController.dart';
import 'package:elo_clone/views/cartView.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:elo_clone/controllers/cartController.dart';
import 'package:choice/choice.dart';
import 'package:get/get.dart';

class productDetailPage extends StatefulWidget{
  productDetailPage({super.key, required this.product, required this.cart});
  final Product product;
  final FlutterCart cart;

  @override
  State<productDetailPage> createState() => _productDetailPageState();
}

class _productDetailPageState extends State<productDetailPage> {
  String? selectedSize;
  bool expandedText = false;
  String? errorMessage;
  bool isButtonDisabled = false;
  List<String> sizeOptions = [];
  final apiProductController apiController = Get.find();
  final TextEditingController quantityController = TextEditingController(text: "1");

  @override
  void initState() {
    super.initState();
    String category = widget.product.category.toUpperCase();
    if (category == "MEN'S CLOTHING" || category == "WOMEN'S CLOTHING")  {
      sizeOptions = ['S', 'M', 'L'];
    } else if (category == 'JEWELERY') {
      sizeOptions = ['2.4', '2.8', '3.0'];
    }
    else if (category == 'ELECTRONICS') {
      sizeOptions = ['Black', 'Blue', 'White'];
    }

    selectedSize = sizeOptions.isNotEmpty ? sizeOptions[0] : null; // Set default size if available
  }
  void setSelectedValue(String? value) {
    setState(() => selectedSize = value);
  }

  //apiProductController productController = Get.put(apiProductController());
  Widget build(BuildContext context){
    Map<dynamic, dynamic> userDetails = apiController.userDetails;

    final cartController cartControl = Get.put(cartController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail Page'),
        actions: [
          InkWell(
          onTap: () => Get.to( (() => CartView())),
          child: Obx( () {
            return  Badge(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              label: Text(cartControl.getCartCount.toString()),
              child: const Icon(
                Icons.shopping_cart,
              ),
            );})),
          SizedBox(width: 10,)
        ],),
      body: Padding(padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRect(
                clipBehavior: Clip.hardEdge,
                child: Hero(
                    tag: 'product-${widget.product.productId}',
                    child: Image(
                      image: NetworkImage(widget.product.productImage),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,)
                ),
          ),
                Text(widget.product.title, style: Theme.of(context).textTheme.bodyLarge,),
          SizedBox(height: 10,),
            Row(
              children: [
                Text('Category:', style: Theme.of(context).textTheme.displaySmall,),
                SizedBox(width: 20,),
                Text(widget.product.category),
              ],
            ),
            SizedBox(height: 10,),
              Row(
                children: [
                  Text('Price:', style: Theme.of(context).textTheme.displaySmall,),
                  SizedBox(width: 40,),
                  Text(widget.product.price.toStringAsFixed(2)),
                ],
              ),
            SizedBox(height: 10,),
              RatingBar.readOnly(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                halfFilledIcon: Icons.star_half,
                isHalfAllowed: true,
                initialRating: 2.5,
                maxRating: 5,
                alignment: Alignment.center,
              ),
              SizedBox(height: 15,),
          Center(child: Text('Description', style: Theme.of(context).textTheme.displaySmall,),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  widget.product.description,
                  overflow: expandedText ? null : TextOverflow.ellipsis,
                  maxLines: expandedText ? null : 3,
                  softWrap: true,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedText = !expandedText;
                  });
                },
                child: Text(
                  expandedText ? "Read Less" : "Read More",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20,),

              if (sizeOptions.isNotEmpty)
          Choice<String>.inline(
          clearable: true,
          value: ChoiceSingle.value(selectedSize),
          onChanged: ChoiceSingle.onChanged(setSelectedValue),
          itemCount: sizeOptions.length,
          itemBuilder: (state, i) {
            return ChoiceChip(
              selected: state.selected(sizeOptions[i]),
              onSelected: state.onSelected(sizeOptions[i]),
              label: Text(sizeOptions[i]),
            );
          },
          listBuilder: ChoiceList.createScrollable(
            spacing: 10,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
          ),
          ),
              SizedBox(height: 10,),

              SizedBox(
             width: 200,
             child: TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Quantity",
                        border: OutlineInputBorder(),
                        errorText: errorMessage,

                      ),

                      onChanged: (value) {
                        if (int.tryParse(value) == null || int.parse(value) <= 0 || int.parse(value) > 50) {
                          setState(() {
                            errorMessage = 'Enter quantity between 0 - 50';
                            isButtonDisabled = true;

                          });
                        } else {
                          setState(() {
                            errorMessage = null;
                            isButtonDisabled = false;
                          });
                        }
                      },
                    ),
           ),

              SizedBox(height: 15,),

              ElevatedButton(
                  onPressed: isButtonDisabled || selectedSize == null ? null : (){cartControl.addToCart(widget.product, selectedSize! , quantityController.text);
                    Get.to(() => CartView());},
                  child: Text('Add to Cart'))
              ]),
        )
            ,
        ),
      )
    ;
  }
}