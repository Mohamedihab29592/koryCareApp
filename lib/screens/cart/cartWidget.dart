import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../consts/firebase.dart';
import '../../models/cartModel.dart';
import '../../provider/cart_provider.dart';
import '../../provider/orderProvider.dart';
import '../../provider/products_provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utilies.dart';
import '../../widget/heart_btn.dart';
import '../../widget/load.dart';
import '../../widget/textWidget.dart';
import '../innerscreens/productDetails.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.q, }) : super(key: key);
  final int q;


  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quanController = TextEditingController();
  bool _isloading = false;
  String ? _address ;
  String ?_phone;
  final User? user = auth.currentUser;
void getUserData()
async{
  String uid = user!.uid;
  final DocumentSnapshot userData = await FirebaseFirestore.instance.collection("users").doc(uid).get();
  _address =userData.get('shipping_address');
  _phone = userData.get('phone');
}

  @override
  void initState() {
  getUserData();
    _quanController.text = widget.q.toString();

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
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrentProduct = productProvider.findById(cartModel.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    double usedPrice = getCurrentProduct.isOnSale? getCurrentProduct.salePrice :getCurrentProduct.price ;
    final orderProvider = Provider.of<OrderProvider>(context);
    bool inOrder = orderProvider.getOrderItems.containsKey(getCurrentProduct.id);



    double totalPrice = usedPrice * int.parse(_quanController.text);
    final wishlist = Provider.of<WishlistProvider>(context);
    bool ? isWishlist = wishlist.getWishlistItem.containsKey(cartModel.productId);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,arguments: cartModel.productId);
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
                        imageUrl:getCurrentProduct.imageUrl
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width *0.3,
                          child: TextWidget(
                            title: getCurrentProduct.title,
                            color: color,
                            textSize: 20,
                            isTitle: true,
                            maxLine: 1,
                          ),
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
                                    if (_quanController.text == '1') {
                                      return;
                                    } else {
                                      cartProvider.reduceQuantityByone(cartModel.productId);
                                    }
                                    setState(() {
                                      _quanController.text =
                                          (int.parse(_quanController.text) -
                                              1)
                                              .toString();

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
                                    cartProvider.increaseQuantityByone(cartModel.productId);

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
                    Column(
                      children: [
                        InkWell(
                          onTap: () async{
                           await cartProvider.removeItem(productId: cartModel.productId,cartId: cartModel.id,quantity: cartModel.quantity);
                          },
                          child: const Icon(
                            CupertinoIcons.cart_badge_minus,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                         HeartBTN(productId: cartModel.productId,isWishlist: isWishlist,),
                        TextWidget(
                          title: "\$${(usedPrice * int.parse(_quanController.text)) .toStringAsFixed(2)}",
                          color: color,
                          textSize: 18,
                          maxLine: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Material(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: inOrder ? null : () async{
                              setState(() {
                                _isloading = true;
                              });
                              try{

                                if (_phone == null || _phone ==''){
                                  GlobalMethods.errorDialog(subTitle: "Please add your phone Number in your profile screen first", context: context);
                                  return;

                                }

                                else{
                                  await orderProvider.addProductToOrder(isOnSale:getCurrentProduct.isOnSale,total: totalPrice, cartProvider: cartProvider, productProvider: productProvider, context: context, quantity:cartModel.quantity , productId:cartModel.productId, phone: _phone!, shipping: _address!, title: getCurrentProduct.title,items:getCurrentProduct.items, salePrice: getCurrentProduct.salePrice, price: getCurrentProduct.price, imageUrl:getCurrentProduct.imageUrl);
                                  await orderProvider.fetchOrders();
                                  setState(() {
                                    _isloading = false;

                                  });
                                }

                              }catch(error)
                              {
                                GlobalMethods.errorDialog(subTitle: error.toString(), context: context);

                              }finally{
                                setState(() {
                                  _isloading = false;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _isloading ? const Loading():TextWidget(
                                title: inOrder ? 'Ordered':'Order Now',
                                color: Colors.white,
                                textSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
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
