import 'package:flutter/material.dart';
import 'package:grocery_app/widget/textWidget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {},
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/google.png',
              width: 40.0,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          TextWidget(
              title: 'Sign in with google', color: Colors.white, textSize: 18)
        ]),
      ),
    );
  }
}
