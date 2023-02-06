import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/consts/firebase.dart';
import 'package:grocery_app/models/cartModel.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }
  final userCollection = FirebaseFirestore.instance.collection('users');

  void addProductToCart({required String productId,
    required int quantity,
    required BuildContext context}) async {
    final User? user = auth.currentUser;

    final cartId = const Uuid().v4();
    try {
      userCollection.doc(user!.uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Item has been added to your cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (error) {
      GlobalMethods.errorDialog(subTitle: error.toString(), context: context);
    }
  }

  Future<void> fetchCart() async {
    final User? user = auth.currentUser;
    final DocumentSnapshot userDoc =
    await userCollection.doc(user!.uid).get();

    final leng = userDoc.get('userCart').length;
    for (int i = 0; i < leng; i++) {
      _cartItems.putIfAbsent(
          userDoc.get('userCart')[i]['productId'],
              () => CartModel(
            id: userDoc.get('userCart')[i]['cartId'],
            productId: userDoc.get('userCart')[i]['productId'],
            quantity: userDoc.get('userCart')[i]['quantity'],
          ));
    }
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
  Future <void> removeItem({required String productId,required String cartId, required int quantity})
  async {
    final User? user = auth.currentUser;

    await userCollection.doc(user!.uid).update({'userCart':FieldValue.arrayRemove(
       [ {
          'cartId':cartId  ,
          'productId':productId,
          'quantity': quantity,

        }
        ])});
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();

  }
  Future <void> clear()
  async {
    final User? user = auth.currentUser;

   if(user != null)
     {
       await userCollection.doc(user.uid).update({
         'userCart':[],
       });
     }

    _cartItems.clear();
    notifyListeners();
  }


}
