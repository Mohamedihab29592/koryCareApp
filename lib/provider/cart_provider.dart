import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/cartModel.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addProductToCart({required String productId, required int quantity}) {
    _cartItems.putIfAbsent(
        productId,
        () => CartModel(
            productId: productId,
            id: DateTime.now().toString(),
            quantity: quantity));
    notifyListeners();


  }
  void reduceQuantityByone (String productId)
  { _cartItems.update(productId, (value) => CartModel(
      productId: productId,
      id: value.id,
      quantity: value.quantity-1));

  notifyListeners();

  }
  void increaseQuantityByone (String productId)
  { _cartItems.update(productId, (value) => CartModel(
      productId: productId,
      id: value.id,
      quantity: value.quantity+1));

  notifyListeners();

  }
  void removeItem(String productId)
  {
    _cartItems.remove(productId);
    notifyListeners();

  }
  void clear()
  {
    _cartItems.clear();
    notifyListeners();
  }
}
