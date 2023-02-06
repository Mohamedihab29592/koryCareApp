import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/models/orderModel.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebase.dart';
import '../services/global_methods.dart';
import 'cart_provider.dart';

class OrderProvider with ChangeNotifier {
 static  List<OrderModel> _orderItems = [];

  List<OrderModel> get getOrderItems {
    return _orderItems;
  }
  final userCollection = FirebaseFirestore.instance.collection('orders');



  Future<void> addProductToOrder({required int quantity,required String productId,required double total,required final cartProvider,required final productProvider
    ,required BuildContext context}) async {
    final User? user = auth.currentUser;
    final orderId = const Uuid().v4();
    try {
      final getCurrentProduct =productProvider.findById(productId);
      userCollection.doc(orderId).set({
        'orderId': orderId,
        'userId': user!.uid,
        'productId': productId,
        'price':(getCurrentProduct.isOnSale? getCurrentProduct.salePrice:getCurrentProduct.price)*quantity,
        'total':total,
        'quantity':quantity,
        'imageUrl':getCurrentProduct.imageUrl,
        'userName':user.displayName,
        'orderDate':Timestamp.now(),
      });

      await Fluttertoast.showToast(
        msg: "Your Order has Been Placed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

    } catch (error) {
      GlobalMethods.errorDialog(subTitle: error.toString(), context: context);
    }finally{}
  }


  Future<void> fetchOrders() async {

    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _orderItems.clear();
      for (var element in productSnapshot.docs) {
        _orderItems.insert(
            0,
            OrderModel(
              orderId: element.get('orderId'),
              userId: element.get('userId'),
              userName: element.get('userName'),
              price: element.get('price').toString(),
              imageUrl: element.get('imageUrl'),
              quantity: element.get('quantity').toString(),
              orderDate: element.get('orderDate'),
              productId: element.get('productId'),

            ));
      }
    });
    notifyListeners();
  }

}

