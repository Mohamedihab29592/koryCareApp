import 'package:flutter/material.dart';
import 'package:grocery_app/screens/orderScreen/orderWidget.dart';
import 'package:grocery_app/widget/backWidget.dart';
import 'package:grocery_app/widget/emptyScreen.dart';
import 'package:provider/provider.dart';

import '../../provider/orderProvider.dart';
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
    final orderProvider = Provider.of<OrderProvider>(context);
    final orderList = orderProvider.getOrderItems;

    return FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
      return orderList.isEmpty
          ? const EmptyScreen(
              title: 'No Orders',
              subTitle: "Try to Order Some",
              image: "assets/choices.png",
              btnTitle: 'Order Now')
          : Scaffold(
              appBar: AppBar(
                leading: const BackWidget(),
                elevation: 0,
                centerTitle: true,
                title: TextWidget(
                  title: 'Your Orders (${orderList.length})',
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                backgroundColor:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 6),
                        child: ChangeNotifierProvider.value(
                          value: orderList[index],
                          child: const OrderWidget(),
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: color,
                      thickness: 1,
                    );
                  },
                  itemCount: orderList.length));
    });
  }
}
