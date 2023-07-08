import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../models/wishListModel.dart';
import '../../provider/products_provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../services/utilies.dart';
import '../../widget/heart_btn.dart';
import '../../widget/textWidget.dart';
import '../innerscreens/productDetails.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlist = Provider.of<WishlistProvider>(context);
    final getCurrentProduct = productProvider.findById(wishlistModel.productId);
    double usedPrice = getCurrentProduct.isOnSale? getCurrentProduct.salePrice :getCurrentProduct.price ;


    bool ? isWishlist = wishlist.getWishlistItem.containsKey(getCurrentProduct.id);
    final Color color =Utils(context).color;
    final Size size =Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,arguments: wishlistModel.productId);
          },
          child: Container(
            height: size.height*0.20,
decoration: BoxDecoration(
  color: Theme.of(context).cardColor,
  border:Border.all(color: color,width: 1),
  borderRadius: BorderRadius.circular(8.0),

),
            child: Row(children: [Flexible(
              flex: 2,
              child: Container(margin: const EdgeInsets.only(left: 8),
                height: size.width*0.25,
                child:             FancyShimmerImage(
                  boxFit: BoxFit.fill,

                  imageUrl: getCurrentProduct.imageUrl,),

              ),
            ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Flexible(
                    child: Row(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(IconlyLight.bag_2,color: color,)),
                         HeartBTN(productId:getCurrentProduct.id,isWishlist: isWishlist,)
                      ],
                    ),
                  ),
                    TextWidget(title: getCurrentProduct.title,color: color,textSize: 20,maxLine: 2,isTitle: true,),
                    const SizedBox(height: 5,),
                    TextWidget(title: "\$${usedPrice.toString()}",color: color,textSize: 18,maxLine: 1,isTitle: true,)
                  ],
                ),
              ),

            ],),


          )),
    );
  }
}
