import 'package:flutter/material.dart';
import 'package:grocery_app/screens/orderScreen/orderWidget.dart';
import 'package:grocery_app/widget/backWidget.dart';
import 'package:grocery_app/widget/emptyCart.dart';

import '../../services/utilies.dart';
import '../../widget/textWidget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = "/orderScreen";


  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    bool _isEmpty = true;

    return _isEmpty ? const EmptyScreen(title: 'No Orders', image: "assets/choices.png", btnTitle: 'Order Now') :Scaffold(
      appBar: AppBar(leading:
        const BackWidget(),
      elevation: 0,
      centerTitle: true,
      title: TextWidget(title:'Your Orders (3)',color:color,textSize: 24,isTitle: true,


      ),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),



    ),
    body: ListView.separated(itemBuilder: (context,index){

      return const Padding(
        padding:  EdgeInsets.symmetric(horizontal:2.0,vertical: 6),
        child: OrderWidget(),
      );

    }, separatorBuilder: (context,index){return Divider(color: color,thickness: 1,);}, itemCount: 10)
    );}
}
