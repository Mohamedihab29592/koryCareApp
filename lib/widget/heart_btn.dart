import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utilies.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../consts/firebase.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({Key? key, required this.productId,  this.isWishlist= false}) : super(key: key);
  final String productId;
  final bool isWishlist;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishlistProvider =Provider.of<WishlistProvider>(context);
    return GestureDetector(
      onTap: () {
        final User? user = auth.currentUser;
        if(user ==null)
          {
            GlobalMethods.errorDialog(subTitle: "Please Register First", context: context);
            return;
          }
        wishlistProvider.addAndRemoveWishlist(productId: productId);
      },
      child: Icon(
        isWishlist? IconlyBold.heart:
        IconlyLight.heart,
        size: 22,
        color:isWishlist ? Colors.red: color,
      ),
    );

  }
}
