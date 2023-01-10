import 'package:flutter/material.dart';
import 'package:grocery_app/screens/viewedOnlyScreen/viewedWidget.dart';
import 'package:grocery_app/widget/backWidget.dart';
import 'package:grocery_app/widget/emptyCart.dart';

import '../../services/utilies.dart';
import '../../widget/textWidget.dart';

class ViewedScreen extends StatefulWidget {
  const ViewedScreen({Key? key}) : super(key: key);
  static const routeName = "/viewScreen";


  @override
  State<ViewedScreen> createState() => _ViewedScreenState();
}

class _ViewedScreenState extends State<ViewedScreen> {

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    bool _isEmpty = true;

    return _isEmpty ? const EmptyScreen(title: 'No Viewed Item Yet',image: 'assets/analysis.png',btnTitle: 'Show Products',)  :Scaffold(
        appBar: AppBar(leading:
        const BackWidget(),
    title: TextWidget(title:'Viewed',color:color,textSize: 24,isTitle: true,
    ),
    elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),



        ),
        body: ListView.separated(itemBuilder: (context,index){

          return const Padding(
            padding:  EdgeInsets.symmetric(horizontal:2.0,vertical: 6),
            child: ViewedWidget(),
          );

        }, separatorBuilder: (context,index){return Divider(color: color,thickness: 1,);}, itemCount: 10)
    );}
}
