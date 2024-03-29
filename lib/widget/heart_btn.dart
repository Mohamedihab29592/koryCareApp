import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:KoryCare/provider/products_provider.dart';
import 'package:KoryCare/provider/wishlist_provider.dart';
import 'package:KoryCare/services/global_methods.dart';
import 'package:KoryCare/services/utilies.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../consts/firebase.dart';
import 'load.dart';

class HeartBTN extends StatefulWidget {
  const HeartBTN({Key? key, required this.productId,  this.isWishlist= false}) : super(key: key);
  final String productId;
  final bool isWishlist;

  @override
  State<HeartBTN> createState() => _HeartBTNState();
}


class _HeartBTNState extends State<HeartBTN> {
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishlistProvider =Provider.of<WishlistProvider>(context);
    final productProvider =Provider.of<ProductsProvider>(context);
    final getCurrentProduct =productProvider.findById(widget.productId);
    return GestureDetector(
      onTap: () async{
        setState(() {
          _isloading = true;
        });
        try {
          final User? user = auth.currentUser;
          if(user ==null)
          {
            GlobalMethods.errorDialog(subTitle: "Please Register First", context: context);
            return;
          }
          if (widget.isWishlist == false ) {
            wishlistProvider.addAWishlist(productId: widget.productId,context: context);


          }
          else {
            wishlistProvider.removeItem(productId: widget.productId, wishListId: wishlistProvider.getWishlistItem[getCurrentProduct.id]!.id);
          }
          await wishlistProvider.fetchWish();
          setState(() {
            _isloading = false;

          });

        } catch (error){
          GlobalMethods.errorDialog(subTitle: error.toString(), context: context);

        }finally{
          setState(() {
            _isloading = false;

          });


        }
      },
      child:_isloading ? const Loading():
      Icon(
        widget.isWishlist? IconlyBold.heart:
        IconlyLight.heart,
        size: 22,
        color:widget.isWishlist ? Colors.red: color,
      ),
    );

  }
}
