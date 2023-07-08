import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/orderModel.dart';
import '../../provider/products_provider.dart';
import '../../services/utilies.dart';
import '../../widget/textWidget.dart';
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
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final orderModel = Provider.of<OrderModel>(context);

    final productProvider = Provider.of<ProductsProvider>(context);
    final getOrderData =productProvider.findById(orderModel.productId);

    return ListTile(
      subtitle:  Text('Total: \$${orderModel.total}'),
      onTap: ()
      {
        Navigator.pushNamed(context, ProductDetails.routeName,arguments: getOrderData.id);
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
          title: TextWidget(title: "${getOrderData.title} x${orderModel.quantity}",color: color,textSize: 18,),
          trailing: TextWidget(title: orderDateShow,color: color,textSize: 18,),
        );
      }

  }

