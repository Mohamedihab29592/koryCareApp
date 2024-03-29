import 'package:KoryCare/provider/cart_provider.dart';
import 'package:KoryCare/provider/orderProvider.dart';
import 'package:KoryCare/provider/products_provider.dart';
import 'package:KoryCare/provider/wishlist_provider.dart';
import 'package:KoryCare/screens/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';

import 'auth/login.dart';
import 'consts/contss.dart';
import 'consts/firebase.dart';


class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Constss.authImagesPaths;

  @override
  void initState() {
    images.shuffle();
    final  User? user = auth.currentUser;

    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider =
      Provider.of<CartProvider>(context, listen: false);
      final wishProvider =
      Provider.of<WishlistProvider>(context, listen: false);
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      if(user == null )
        {
          await productsProvider.fetchProducts();
           await cartProvider.clear();
         await   wishProvider.clear();
         await   orderProvider.clear();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => const LoginScreen(),));

        }
      else
        {
          await productsProvider.fetchProducts();
          await cartProvider.fetchCart();
          await wishProvider.fetchWish();
          await orderProvider.fetchOrders();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) => const BottomBarScreen(),
          ));

        }



    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
