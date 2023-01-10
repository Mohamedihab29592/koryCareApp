import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/screens/productDetails.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widget/priceWidget.dart';
import 'package:grocery_app/widget/textWidget.dart';

import '../services/utilies.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _textController = TextEditingController();
  @override
  void initState() {
_textController.text="1";
super.initState();
  }
  @override
  void dispose() {
_textController.dispose();
super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    Size size = Utils(context).screenSize;
    Color color = Utils(context).color;


  return  Material(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor,
      child: InkWell(onTap: (){
        GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);
      },
        borderRadius: BorderRadius.circular(12),
        child:Column(
          children: [
            FancyShimmerImage(
              boxFit: BoxFit.fill,
              height: size.height*0.17,
              width: size.width*0.40,
              imageUrl: 'https://ae01.alicdn.com/kf/H67784845dad144f4bf6ad5ab780fc4f5g/9Pcs-Set-Makeup-Set-Gift-Box-Cosmetic-Set-Mushroom-Air-Cushion-BB-Cream-Concealer-Powder-Velvet.jpg_480x480q90.jpg_.webp',),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [TextWidget(title: "title", color: color, textSize: 20,isTitle: true,),const HeartBTN()],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Flexible(flex:2, child: PriceWidget(salePrice: 2.99, price: 5.5, textPrice: _textController.text, isOnSale: true,)),

                  Flexible(
                    child: Row(children: [
                      const Spacer(),

                      Flexible(flex:1,child: TextFormField(controller: _textController,
                      key: const ValueKey("10"),
                      style: TextStyle(color: color,fontSize: 18,
                      ),keyboardType: TextInputType.number,
                      minLines: 1,
                      enabled: true,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty)
                              {
                                _textController.text= "1";
                              }
                            else {
                            }

                          });
                        },
                      ))
                    ],),
                  )
              ],),
            ),
            TextButton(onPressed: (){},
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))))), child: TextWidget(title: 'Add to Cart', color: color, textSize: 20,maxLine: 1,),
            )

          ],
        ),

      ),
    );
  }
}
