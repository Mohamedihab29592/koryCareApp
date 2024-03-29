import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../../provider/products_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utilies.dart';
import '../../widget/emptyScreen.dart';
import '../../widget/textWidget.dart';
import 'cartWidget.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.getCartItems.values.toList().reversed.toList();
    return cartList.isEmpty
        ? const EmptyScreen(
            title: 'No Items In your Cart',
            subTitle:'No Products Added to your Cart' ,
            image: 'assets/add-to-cart.png',
            btnTitle: 'Browse Products',
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                title: 'Cart (${cartList.length})',
                color: color,
                isTitle: true,
                textSize: 22,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: "Empty Your Card?",
                          subTitle: "Are you sure?",
                          fct: () {
                            cartProvider.clear();
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyBold.delete,
                      color: color,
                    ))
              ],
            ),
            body: Column(
              children: [
                _checkOut(size: size, color: color, context: context),
                Expanded(
                    child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) =>
                            ChangeNotifierProvider.value(
                                value: cartList[index], child: CartWidget(q: cartList[index].quantity,)))),
              ],
            ));
  }

  Widget _checkOut({required Size size, required Color color,required BuildContext context}) {
    final cartProvider = Provider.of<CartProvider>(context,);
    final productProvider = Provider.of<ProductsProvider>(context);
    double total =0;
    cartProvider.getCartItems.forEach((key, value){
    final getCurrentProduct = productProvider.findById(value.productId);
   total += (getCurrentProduct.isOnSale? getCurrentProduct.salePrice:getCurrentProduct.price)* value.quantity;
   });
    return SizedBox(
      height: size.height * 0.1,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [

            const Spacer(),
            TextWidget(
              title: 'Total ${total.toStringAsFixed(2)}',
              color: color,
              textSize: 18,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
