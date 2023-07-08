import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../consts/contss.dart';
import '../models/products_model.dart';
import '../provider/products_provider.dart';
import '../services/global_methods.dart';
import '../services/utilies.dart';
import '../widget/feed_item.dart';
import '../widget/onSaleWidget.dart';
import '../widget/textWidget.dart';
import 'innerscreens/feedsScreen.dart';
import 'innerscreens/onSaleScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> onSaleProducts = productProviders.getOnSaleProducts;


    Size size = utils.screenSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: size.height * 0.35,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      Constss.offerImages[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: Constss.offerImages.length,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.blue)),
                )),
            const SizedBox(
              height: 6,
            ),
            TextButton(
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: OnSale.routeName);
                },
                child: TextWidget(
                  title: 'View All',
                  maxLine: 1,
                  color: Colors.blue,
                  textSize: 20,
                )),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Row(
                      children: [
                        TextWidget(
                            title: "ON SALE",
                            color: Colors.red,
                            textSize: 22,
                            isTitle: true),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          IconlyLight.discount,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(

                  child: SizedBox(
                    height: size.height * 0.17,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: onSaleProducts.length,
                        itemBuilder: (context, index) {
                          return  ChangeNotifierProvider.value(
                            value: onSaleProducts[index],
                            child: const OnSaleWidget(),
                          );
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    title: "Our Product",
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context, routeName: FeedsScreen.routeName);
                      },
                      child: TextWidget(
                        title: 'Browse all',
                        maxLine: 1,
                        color: Colors.blue,
                        textSize: 20,
                      )),
                ],
              ),
            ),
            GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.55),
              children: List.generate(allProducts.length, (index)  {
                return ChangeNotifierProvider.value(
                  value: allProducts[index],
                  child: const FeedsWidget(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
