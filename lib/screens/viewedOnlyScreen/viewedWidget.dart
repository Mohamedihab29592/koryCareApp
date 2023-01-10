import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/productDetails.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widget/textWidget.dart';

import '../../services/utilies.dart';

class ViewedWidget extends StatefulWidget {
  const ViewedWidget({Key? key}) : super(key: key);

  @override
  State<ViewedWidget> createState() => _ViewedWidgetState();
}

class _ViewedWidgetState extends State<ViewedWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(
              ctx: context, routeName: ProductDetails.routeName);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FancyShimmerImage(
              width: size.width * 0.25,
              height: size.width *0.27,
              boxFit: BoxFit.fill,
              imageUrl:
                  'https://ae01.alicdn.com/kf/H67784845dad144f4bf6ad5ab780fc4f5g/9Pcs-Set-Makeup-Set-Gift-Box-Cosmetic-Set-Mushroom-Air-Cushion-BB-Cream-Concealer-Powder-Velvet.jpg_480x480q90.jpg_.webp',
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                TextWidget(
                  title: 'title',
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextWidget(title: '\$12.88', color: color, textSize: 20),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
                child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.add,
                        color: color,
                        size: 20,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
