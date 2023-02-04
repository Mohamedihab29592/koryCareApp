import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String id, title, imageUrl, productCategoryName;
  final double price, salePrice;
  final bool isOnSale;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.salePrice,
      required this.imageUrl,
      required this.isOnSale,
      required this.productCategoryName});
}
