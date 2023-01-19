import 'package:flutter/material.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/screens/cart/cartWidget.dart';
import 'package:grocery_app/widget/emptyScreen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utilies.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

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
                _checkOut(size: size, color: color),
                Expanded(
                    child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) =>
                            ChangeNotifierProvider.value(
                                value: cartList[index], child: CartWidget(q: cartList[index].quantity,)))),
              ],
            ));
  }

  Widget _checkOut({required Size size, required Color color}) {
    return SizedBox(
      height: size.height * 0.1,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    title: 'Order Now',
                    color: Colors.white,
                    textSize: 20,
                  ),
                ),
              ),
            ),
            const Spacer(),
            TextWidget(
              title: "Total \$0.259",
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
