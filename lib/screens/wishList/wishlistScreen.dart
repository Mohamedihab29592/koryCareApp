import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/wishList/wishListWidget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utilies.dart';
import 'package:grocery_app/widget/backWidget.dart';
import 'package:grocery_app/widget/emptyScreen.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../provider/wishlist_provider.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);
  static const routeName = "/wishList";

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    final wishlist = Provider.of<WishlistProvider>(context);
    final wishlistItems = wishlist.getWishlistItem.values.toList().reversed.toList();
    return wishlistItems.isEmpty?
    const EmptyScreen(title: 'No Wish List added', image: 'assets/wishlist.png', btnTitle: 'Add Your WishList',subTitle: 'Try to Add Some',) :Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            title: 'Wishlist (${wishlistItems.length})',
            color: color,
            isTitle: true,
            textSize: 22,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(title: "Empty Your Wishlist?", subTitle: "Are you sure?", fct: (){
                    wishlist.clear();
                  }, context: context);

                },
                icon: Icon(
                  IconlyBold.delete,
                  color: color,
                ))
          ],
        ),
        body: MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: wishlistItems.length,

          itemBuilder: (context, index) {
            return  ChangeNotifierProvider.value(value: wishlistItems[index],child: const WishlistWidget());
          },
        ),
        );
  }
}
