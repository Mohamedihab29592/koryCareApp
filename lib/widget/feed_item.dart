import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:KoryCare/provider/cart_provider.dart';
import 'package:KoryCare/provider/wishlist_provider.dart';
import 'package:KoryCare/services/global_methods.dart';
import 'package:KoryCare/widget/priceWidget.dart';
import 'package:KoryCare/widget/textWidget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../consts/firebase.dart';
import '../models/products_model.dart';
import '../screens/innerscreens/productDetails.dart';
import '../services/utilies.dart';
import 'heart_btn.dart';
import 'load.dart';

class FeedsWidget extends StatefulWidget {
   const FeedsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = "1";
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlist = Provider.of<WishlistProvider>(context);
    bool ? isWishlist = wishlist.getWishlistItem.containsKey(productModel.id);
    bool ? isInCart  =  cartProvider.getCartItems.containsKey(productModel.id);


    Size size = Utils(context).screenSize;
    Color color = Utils(context).color;

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName,arguments: productModel.id);
          // GlobalMethods.navigateTo(
          //     ctx: context, routeName: ProductDetails.routeName);
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            FancyShimmerImage(
              boxFit: BoxFit.fill,
              height: size.height * 0.17,
              width: size.width * 0.40,
              imageUrl: productModel.imageUrl,
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 3,
                      child: TextWidget(
                        title: productModel.title,
                        color: color,
                        textSize: 20,
                        isTitle: true,
                        maxLine: 1,
                      )),

                   Flexible(flex: 1, child: HeartBTN(productId: productModel.id,isWishlist: isWishlist,))
                ],
              ),
            ),
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PriceWidget(
                        salePrice: productModel.salePrice,
                        price: productModel.price,
                        textPrice: _textController.text,
                        isOnSale: productModel.isOnSale,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap:isInCart?null: () async{
                          setState(() {
                            isloading = true;

                          });
                          try {

                            final User? user = auth.currentUser;
                            if(user ==null)
                            {
                              GlobalMethods.errorDialog(subTitle: "Please Register First", context: context);
                              return;
                            }
                            cartProvider.addProductToCart(productId: productModel.id, quantity: 1,context: context);

                            await cartProvider.fetchCart();
                            setState(() {
                              isloading = false;
                            });
                          }catch(error){
                            GlobalMethods.errorDialog(subTitle: error.toString(), context: context);
                          }finally{
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                        child:isloading ? const Loading():
                      Icon( isInCart?
                          IconlyBold.bag_2:
                          IconlyLight.bag_2,
                          size: 22,
                          color: isInCart?Colors.green:color,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
