import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/widget/heart_btn.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';

import '../services/utilies.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/productDetails';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityController = TextEditingController(text: "1");

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    final Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () =>
              Navigator.canPop(context) ? Navigator.pop(context) : null,
          child: Icon(
            IconlyLight.arrow_left_2,
            color: color,
            size: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Flexible(
              flex: 2,
              child: FancyShimmerImage(
                imageUrl:
                    'https://ae01.alicdn.com/kf/H67784845dad144f4bf6ad5ab780fc4f5g/9Pcs-Set-Makeup-Set-Gift-Box-Cosmetic-Set-Mushroom-Air-Cushion-BB-Cream-Concealer-Powder-Velvet.jpg_480x480q90.jpg_.webp',
                boxFit: BoxFit.scaleDown,
                width: size.width,
              )),
          Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 29, left: 38, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWidget(
                              title: "title",
                              color: color,
                              textSize: 25,
                              isTitle: true,
                            ),
                          ),
                          const HeartBTN(),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 29, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextWidget(
                            title: "%2.59",
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          TextWidget(title: "KG", color: color, textSize: 12),
                          const SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: true,
                            child: Text(
                              '\$8.9',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: color,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(63, 200, 101, 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextWidget(
                              title: 'Free Delivery',
                              color: color,
                              textSize: 20,
                              isTitle: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QuanityController(
                            fun: () {
                             setState(() {
                               if (_quantityController.text == '1')
                               {
                                 return;
                               }
                               else {
                                 _quantityController.text = (int.parse(_quantityController.text)-1).toString();
                               }
                             });
                            },
                            icon: CupertinoIcons.minus,
                            color: Colors.red),
                        Flexible(
                            child: TextField(
                          controller: _quantityController,
                          key: const ValueKey('quantity'),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration:
                              const InputDecoration(border: UnderlineInputBorder()),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[0-9]'),
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                _quantityController.text = '1';
                              } else {}
                            });
                          },
                        )),
                        QuanityController(
                            fun: () {
setState(() {
  _quantityController.text = (int.parse(_quantityController.text)+1).toString();

});
                            },
                            icon: CupertinoIcons.plus,
                            color: Colors.green),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: size.width,
                      padding:
                          const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                title: "Total",
                                color: Colors.red.shade300,
                                textSize: 20,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    TextWidget(
                                      title: "\$2.50/",
                                      color: color,
                                      textSize: 20,
                                      isTitle: true,
                                    ),
                                    TextWidget(
                                      title: '${_quantityController.text} Item',
                                      color: color,
                                      textSize: 16,
                                      isTitle: false,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                              child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                    title: 'Add to Cart',
                                    color: Colors.white,
                                    textSize: 18,
                                  ),
                                )),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget QuanityController(
      {required Function fun, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                fun();
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              )),
        ),
      ),
    );
  }
}
