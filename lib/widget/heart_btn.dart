import 'package:flutter/cupertino.dart';
import 'package:grocery_app/services/utilies.dart';
import 'package:iconly/iconly.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {},
      child: Icon(
        IconlyLight.heart,
        size: 22,
        color: color,
      ),
    );

  }
}
