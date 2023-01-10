import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/wishList/wishListWidget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utilies.dart';
import 'package:grocery_app/widget/backWidget.dart';
import 'package:grocery_app/widget/emptyCart.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);
  static const routeName = "/wishList";

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    bool _isEmpty = true;
    return _isEmpty?const EmptyScreen(title: 'No Wish List added', image: 'assets/wishlist.png', btnTitle: 'Add Your WishList') :Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            title: 'Wishlist (2)',
            color: color,
            isTitle: true,
            textSize: 22,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(title: "Empty Your Wishlist?", subTitle: "Are you sure?", fct: (){}, context: context);

                },
                icon: Icon(
                  IconlyBold.delete,
                  color: color,
                ))
          ],
        ),
        body: MasonryGridView.count(
          crossAxisCount: 2,

          itemBuilder: (context, index) {
            return const WishlistWidget();
          },
        ),
        );
  }
}
