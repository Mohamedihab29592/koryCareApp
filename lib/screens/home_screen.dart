import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utilies.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';

import '../widget/feed_item.dart';
import '../widget/onSaleWidget.dart';
import 'feedsScreen.dart';
import 'onSaleScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImage = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',

  ];

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;

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
                      _offerImage[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: _offerImage.length,
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
                RotatedBox(
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
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.17,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const OnSaleWidget();
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
              childAspectRatio: size.width / (size.height * 0.66),
              children: List.generate(
                4,
                (index) => const FeedsWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
