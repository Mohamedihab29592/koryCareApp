import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/widget/heart_btn.dart';

import '../../services/global_methods.dart';
import '../../services/utilies.dart';
import '../../widget/textWidget.dart';
import '../productDetails.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quanController = TextEditingController();

  @override
  void initState() {
    _quanController.text = "1";
    super.initState();
  }

  @override
  void dispose() {
    _quanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    Color color = Utils(context).color;

    return GestureDetector(
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.17,
                      width: size.width * 0.40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: FancyShimmerImage(
                        boxFit: BoxFit.fill,
                        imageUrl:
                            'https://ae01.alicdn.com/kf/H67784845dad144f4bf6ad5ab780fc4f5g/9Pcs-Set-Makeup-Set-Gift-Box-Cosmetic-Set-Mushroom-Air-Cushion-BB-Cream-Concealer-Powder-Velvet.jpg_480x480q90.jpg_.webp',
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: "Title",
                          color: color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            children: [
                              quanityController(
                                  fun: () {
                                    setState(() {
                                      if (_quanController.text == '1') {
                                        return;
                                      } else {
                                        _quanController.text =
                                            (int.parse(_quanController.text) -
                                                    1)
                                                .toString();
                                      }
                                    });
                                  },
                                  icon: CupertinoIcons.minus,
                                  color: Colors.red),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quanController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide())),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      if (v.isEmpty) {
                                        _quanController.text = "1";
                                      }
                                    });
                                  },
                                ),
                              ),
                              quanityController(
                                  fun: () {
                                    setState(() {
                                      _quanController.text =
                                          (int.parse(_quanController.text) + 1)
                                              .toString();
                                    });
                                  },
                                  icon: CupertinoIcons.plus,
                                  color: Colors.green),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const HeartBTN(),
                          TextWidget(
                            title: '\$0.29',
                            color: color,
                            textSize: 18,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget quanityController(
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
