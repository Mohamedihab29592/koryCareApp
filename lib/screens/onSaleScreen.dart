import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/widget/onSaleWidget.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';

import '../services/utilies.dart';
import '../widget/feed_item.dart';

class OnSale extends StatelessWidget {
  const OnSale({Key? key}) : super(key: key);
  static const routeName = "/onSaleScreen";

  @override

  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    bool _isEmpty = false;

    final themeState =utils.getTheme;
    Size size = utils.screenSize;
    return  Scaffold(
      appBar: AppBar(

        title:TextWidget(title:"Product on Sale", color: color, textSize: 24,isTitle: true,),backgroundColor: Theme.of(context).cardColor,elevation: 0,leading: InkWell(child: Icon(IconlyLight.arrow_left_2,color: color,),onTap: (){Navigator.pop(context);},),),
      body:_isEmpty ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(IconlyLight.danger,size: 200,),
            Text("No Products On Sale Yet!!\n Stay tuned ",textAlign: TextAlign.center,style: TextStyle(color: color,fontSize: 40,fontWeight: FontWeight.w700),),
          ],
        )
      )
          : GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      crossAxisCount: 1, childAspectRatio: size.width/(size.height*0.17),
      children: List.generate(20, (index) =>OnSaleWidget(),
      ),),
        );
  }
}
