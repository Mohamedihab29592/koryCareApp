import 'package:flutter/material.dart';


import '../services/utilies.dart';
import '../widget/categories_widget.dart';
import '../widget/textWidget.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({Key? key}) : super(key: key);

   final List<Map<String,dynamic>> catInfo = [
    {
      'imagePath' :'https://ae01.alicdn.com/kf/H0063bcac45f24f93ae91a76213d8697a9.jpg',
      'catText':'MAKEUP SET',

    },
    {
      'imagePath' :'https://ae01.alicdn.com/kf/H692217df3b7b4fda94ad97257e696f8ds.jpg',
      'catText':'Cosmetics Tools',

    },

    {
      'imagePath' :'https://ae01.alicdn.com/kf/Hca1dae55a5894e90b620a775e7ca83f8D.jpg',
      'catText':'Skin Care',

    },
  ];

  @override
  Widget build(BuildContext context) {
    final utils=  Utils(context);
    Color color = utils.color;
    return Scaffold(
      appBar: AppBar(elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: TextWidget(title: "Categories",color:color, textSize: 24 ,isTitle: true,),),
      body: GridView.count(
        crossAxisCount: 1,
      mainAxisSpacing: 20,
      children: List.generate(3, (index) {
        return CategoriesWidget(catText: catInfo[index]['catText'], imagePath: catInfo[index]['imagePath'],);
      }),),);
  }
}
