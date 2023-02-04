import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/cartModel.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/services/utilies.dart';
import 'package:grocery_app/widget/priceWidget.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../consts/firebase.dart';
import '../models/products_model.dart';
import '../provider/wishlist_provider.dart';
import '../screens/innerscreens/productDetails.dart';
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
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool ? isInCart  =  cartProvider.getCartItems.containsKey(productModel.id);
    final wishlist = Provider.of<WishlistProvider>(context);
    bool ? isWishlist = wishlist.getWishlistItem.containsKey(productModel.id);


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
            Navigator.pushNamed(context, ProductDetails.routeName,arguments: productModel.id);
            // GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);

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
                      imageUrl: productModel.imageUrl
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: productModel.title,
                          color: color,
                          textSize: 22,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                final User? user = auth.currentUser;
                                if(user ==null)
                                {
                                  GlobalMethods.errorDialog(subTitle: "Please Register First", context: context);
                                  return;
                                }
                                cartProvider.addProductToCart(productId: productModel.id, quantity: 1,context: context);
                                cartProvider.fetchCart();
                              },
                              child: Icon(isInCart? IconlyBold.bag_2:
                                IconlyLight.bag_2,
                                size: 22,
                                color:isInCart ? Colors.green: color,
                              ),
                            ),
                            HeartBTN(productId: productModel.id,isWishlist: isWishlist,),                      ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         PriceWidget(
                          salePrice: productModel.salePrice, price: productModel.price, textPrice: '1', isOnSale: productModel.isOnSale,),

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
