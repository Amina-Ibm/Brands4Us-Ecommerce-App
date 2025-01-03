import 'package:elo_clone/models/product.dart';
import 'package:get/get.dart';
import 'package:flutter_cart/flutter_cart.dart';

class cartController extends GetxController{
  var cart = FlutterCart().obs;
  void addToCart(Product product, String size, String quantity) {
    cart.value.addToCart(
      cartModel: CartModel(
          productId: product.productId.toString(),
          productName: product.title,
          productImages: [
            product.productImage
          ],
          quantity: int.parse(quantity),
          variants: [
            ProductVariant(price: product.price, size: size),

      ],
          productDetails: product.description,
          ),
    );
    cart.refresh();
  }
  void updateQuantity(CartModel modelItem, int newQuantity) {
    cart.value.updateQuantity(
        modelItem.productId.toString(), modelItem.variants, newQuantity);
    cart.refresh();
  }

  void removeItemFromCart(CartModel modelItem) {
    cart.value.removeItem(modelItem.productId.toString(), modelItem.variants);
    cart.refresh();
  }
  int get getCartCount => cart.value.cartItemsList.length;
  List<CartModel> get getCartItems => cart.value.cartItemsList;
  double get getTotalAmount => cart.value.total;
  double get subtotal => cart.value.subtotal;
}