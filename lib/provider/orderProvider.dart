import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/models/orderModel.dart';

import 'package:uuid/uuid.dart';

import '../consts/firebase.dart';
import '../services/global_methods.dart';

class OrderProvider with ChangeNotifier {
  static final List<OrderModel> _ordersDash = [];
  List<OrderModel> get getOrdersDash {
    return _ordersDash;
  }


  final Map<String, OrderModel>  _orderItems = {};

  Map<String, OrderModel>  get getOrderItems {
    return _orderItems;


  }
  final userCollection = FirebaseFirestore.instance.collection('users');



  Future<void> addProductToOrder({required String imageUrl,required double price, required double salePrice ,required bool isOnSale, required String items,required String title, required String phone, required String shipping,required int quantity,required String productId,required double total,required final cartProvider,required final productProvider
    ,required BuildContext context}) async {
    final User? user = auth.currentUser;
    final orderId = const Uuid().v4();
    try {

      userCollection.doc(user!.uid).update({
        'userOrder': FieldValue.arrayUnion([
          {
            'orderId': orderId,
            'productId': productId,
            'price':price,
            'total':total,
            'salePrice':salePrice,
            'quantity':quantity,
            'imageUrl':imageUrl,
            'orderDate':Timestamp.now(),
            'userName':user.displayName,
            'userPhone':phone,
            'userShipping':shipping,
            'userId':user.uid,
            'title':title,
            'items':items,
            'isOnSale':isOnSale,
          }
        ])
      });
      FirebaseFirestore.instance.collection('orders').doc(orderId).set({
        'orderId': orderId,
        'productId': productId,
        'price':price,
        'total':total,
        'salePrice':salePrice,
        'quantity':quantity,
        'imageUrl':imageUrl,
        'orderDate':Timestamp.now(),
        'userName':user.displayName,
        'userPhone':phone,
        'userShipping':shipping,
        'userId':user.uid,
        'title':title,
        'items':items,
        'isOnSale':isOnSale,
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

    final User? user = auth.currentUser;
    final DocumentSnapshot userDoc =
    await userCollection.doc(user!.uid).get();

    final leng = userDoc.get('userOrder').length;
    for (int i = 0; i < leng; i++) {
      _orderItems.putIfAbsent(
          userDoc.get('userOrder')[i]['productId'],
              () => OrderModel(
                salePrice: userDoc.get('userOrder')[i]['salePrice'].toString(),
                isOnSale: userDoc.get('userOrder')[i]['isOnSale'] ,
                total: userDoc.get('userOrder')[i]['total'].toString() ,

                orderTitle:userDoc.get('userOrder')[i]['title'] ,
                phone: userDoc.get('userOrder')[i]['userPhone'],
                shipping: userDoc.get('userOrder')[i]['userShipping'],
            orderId: userDoc.get('userOrder')[i]['orderId'],
            productId: userDoc.get('userOrder')[i]['productId'],
            quantity: userDoc.get('userOrder')[i]['quantity'].toString(),
                price: userDoc.get('userOrder')[i]['price'].toString(),
                imageUrl: userDoc.get('userOrder')[i]['imageUrl'],
                orderDate:userDoc.get('userOrder')[i]['orderDate'],
                userId: userDoc.get('userOrder')[i]['userId'],
                userName: userDoc.get('userOrder')[i]['userName'],
                items: userDoc.get('userOrder')[i]['items'],


              ));
    }

    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _ordersDash.clear();
      for (var element in productSnapshot.docs) {
        _ordersDash.insert(
            0,
            OrderModel(
              salePrice: element.get('salePrice').toString(),
              isOnSale: element.get('isOnSale'),
              phone: element.get('userPhone'),
              shipping: element.get('userShipping'),
              orderId: element.get('orderId'),
              userId: element.get('userId'),
              userName: element.get('userName'),
              total: element.get('total').toString(),
              price: element.get('price').toString(),
              imageUrl: element.get('imageUrl'),
              quantity: element.get('quantity').toString(),
              orderDate: element.get('orderDate'),
              productId: element.get('productId'),
              orderTitle: element.get('title'),
              items: element.get('items'),

            ));
      }
    });
    notifyListeners();
  }
  Future <void> clear()
  async {
    final User? user = auth.currentUser;

    if(user != null)
    {
      await userCollection.doc(user.uid).update({
        'userOrder':[],
      });
    }

    _orderItems.clear();
    notifyListeners();
  }
}

