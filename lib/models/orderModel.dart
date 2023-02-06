import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String userId, orderId, userName, price, imageUrl, quantity,productId;
  final Timestamp orderDate;

  OrderModel(
      {required this.userId,
      required this.orderId,
      required this.productId,
      required this.userName,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.orderDate});
}
