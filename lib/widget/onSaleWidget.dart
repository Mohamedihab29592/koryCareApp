import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/services/utilies.dart';
import 'package:grocery_app/widget/priceWidget.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';

import '../screens/productDetails.dart';
import '../services/global_methods.dart';
import 'heart_btn.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);

          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      boxFit: BoxFit.fill,
                      height: size.height*0.13,
                      width: size.width*0.26,
                      imageUrl: 'https://ae01.alicdn.com/kf/H67784845dad144f4bf6ad5ab780fc4f5g/9Pcs-Set-Makeup-Set-Gift-Box-Cosmetic-Set-Mushroom-Air-Cushion-BB-Cream-Concealer-Powder-Velvet.jpg_480x480q90.jpg_.webp',),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: 'Lip Stick',
                          color: color,
                          textSize: 22,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.bag_2,
                                size: 22,
                                color: color,
                              ),
                            ),
                            const HeartBTN(),                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const PriceWidget(salePrice: 2.99, price: 5.5, textPrice: '1', isOnSale: true,),

                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
