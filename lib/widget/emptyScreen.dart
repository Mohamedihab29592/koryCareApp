import 'package:flutter/material.dart';
import 'package:KoryCare/services/global_methods.dart';
import 'package:KoryCare/widget/backWidget.dart';
import 'package:KoryCare/widget/textWidget.dart';

import '../screens/innerscreens/feedsScreen.dart';
import '../services/utilies.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key, required this.title, required this.image, required this.btnTitle, required this.subTitle}) : super(key: key);
  final String title,subTitle;
  final String image;
  final String btnTitle;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    final Size size = Utils(context).screenSize;

    return Scaffold(
      appBar: AppBar(          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation:0,leading: const BackWidget(),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: double.infinity,
            height: size.height * 0.2,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Woophs!!!',
            style: TextStyle(
                color: Colors.red,
                fontSize: 40,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20,
          ),
          TextWidget(
              title: title,
              color: Colors.cyan,
              textSize: 20),
          const SizedBox(
            height: 20,
          ),
          TextWidget(
              title: subTitle,
              color: Colors.cyan,
              textSize: 20),

          SizedBox(
            height: size.height*0.15,
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: color, backgroundColor: Theme.of(context).colorScheme.secondary, elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: color)),
              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),

            ),

            onPressed: () {
              GlobalMethods.navigateTo(
                  ctx: context, routeName: FeedsScreen.routeName);
            },
            child: TextWidget(
              title: btnTitle,
              color:themeState? Colors.grey.shade300:Colors.grey.shade800,
              textSize: 20,
              isTitle: true,
            ),
          ),
        ],
      ),
    );
  }
}
