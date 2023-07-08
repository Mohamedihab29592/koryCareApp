
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:KoryCare/provider/dark_theme_provider.dart';
import 'package:KoryCare/screens/innerscreens/CateogryScreen.dart';
import 'package:KoryCare/widget/textWidget.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key, required this.catText, required this.imagePath,}) : super(key: key);
  final String catText , imagePath;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final color = themeState.getDarkTheme ? Colors.white: Colors.black;
    return  InkWell(
      onTap: (){
        Navigator.pushNamed(context, CategoryScreen.routeName,arguments: catText);
      },
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: ClipRRect(
            borderRadius:
            const BorderRadius.all(Radius.circular(8)),
            child: FancyShimmerImage(
              height: screenWidth*0.8,
              imageUrl: imagePath,
            ),
          ),
        ),
      const SizedBox(height: 10,),
      Container(
        decoration: BoxDecoration(border: Border.all(color: color,width: 1.5)),
          child: TextWidget(title: catText, color:color, textSize: 22, isTitle: false,)),


      ],),
    );
  }
}
