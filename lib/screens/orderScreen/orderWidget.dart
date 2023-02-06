import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/orderModel.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:provider/provider.dart';

import '../../services/utilies.dart';
import '../innerscreens/productDetails.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateShow;

  @override
  void didChangeDependencies() {
final orderModel = Provider.of<OrderModel>(context);
var orderDate = orderModel.orderDate.toDate();
orderDateShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context);
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final productProvider =Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productProvider.findById(orderModel.productId);

    return ListTile(
      subtitle:  Text('paid: \$${double.parse(orderModel.price).toStringAsFixed(2)}'),
      onTap: ()
      {
        Navigator.pushNamed(context, ProductDetails.routeName,arguments: getCurrentProduct.id);
      },
      leading: Container(clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
      ),
        child:  FancyShimmerImage(
          width: size.width *0.2,
          boxFit: BoxFit.fill,
          imageUrl:orderModel.imageUrl,
        ),



      ),
      title: TextWidget(title: "${getCurrentProduct.title} x${orderModel.quantity}",color: color,textSize: 18,),
      trailing: TextWidget(title: orderDateShow,color: color,textSize: 18,),
    );
  }
}
