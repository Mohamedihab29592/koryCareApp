import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../services/utilies.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final Color color = Utils(context).color;


    return InkWell(
      child: Icon(
        IconlyLight.arrow_left_2,
        color: color,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
