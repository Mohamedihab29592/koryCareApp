import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/productDetails.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widget/textWidget.dart';

import '../../services/utilies.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;

    return ListTile(
      subtitle: const Text('paid: \$12.8'),
      onTap: ()
      {
        GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);
      },
      leading: Container(clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
      ),
        child:  FancyShimmerImage(
          width: size.width *0.2,
          boxFit: BoxFit.fill,
          imageUrl:
          'https://ae01.alicdn.com/kf/H67784845dad144f4bf6ad5ab780fc4f5g/9Pcs-Set-Makeup-Set-Gift-Box-Cosmetic-Set-Mushroom-Air-Cushion-BB-Cream-Concealer-Powder-Velvet.jpg_480x480q90.jpg_.webp',
        ),



      ),
      title: TextWidget(title: 'Title x12',color: color,textSize: 18,),
      trailing: TextWidget(title: '03/08/2022',color: color,textSize: 18,),
    );
  }
}
