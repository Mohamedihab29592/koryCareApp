import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/services/utilies.dart';
import 'package:grocery_app/widget/heart_btn.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';

import '../../services/global_methods.dart';
import '../productDetails.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color =Utils(context).color;
    final Size size =Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
          onTap: () {
            GlobalMethods.navigateTo(
                ctx: context, routeName: ProductDetails.routeName);
          },
          child: Container(
            height: size.height*0.20,
decoration: BoxDecoration(
  color: Theme.of(context).cardColor,
  border:Border.all(color: color,width: 1),
  borderRadius: BorderRadius.circular(8.0),

),
            child: Row(children: [Container(margin: const EdgeInsets.only(left: 8),
              width: size.width*0.2,
              height: size.width*0.25,
              child:             FancyShimmerImage(
                boxFit: BoxFit.fill,

                imageUrl: 'https://ae01.alicdn.com/kf/H67784845dad144f4bf6ad5ab780fc4f5g/9Pcs-Set-Makeup-Set-Gift-Box-Cosmetic-Set-Mushroom-Air-Cushion-BB-Cream-Concealer-Powder-Velvet.jpg_480x480q90.jpg_.webp',),

            ),
              Column(
                children: [Flexible(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(IconlyLight.bag_2,color: color,)),
                      const HeartBTN()
                    ],
                  ),
                ),
                  Flexible(child: TextWidget(title: 'title',color: color,textSize: 20,maxLine: 2,isTitle: true,)),
                  const SizedBox(height: 5,),
                  TextWidget(title: '\$2.59',color: color,textSize: 18,maxLine: 1,isTitle: true,)
                ],
              ),

            ],),


          )),
    );
  }
}
