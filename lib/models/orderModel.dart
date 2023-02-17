import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String userId,total, orderId, userName, price, imageUrl, quantity,productId,phone,shipping,orderTitle,items,salePrice;
  final Timestamp orderDate;
  final bool isOnSale;

  OrderModel(
      {required this.userId,
      required this.items,
      required this.total,
      required this.isOnSale,
      required this.salePrice,
      required this.orderId,
      required this.orderTitle,
      required this.productId,
      required this.userName,
      required this.phone,
      required this.shipping,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.orderDate});
}
