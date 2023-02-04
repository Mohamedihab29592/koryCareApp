import 'package:flutter/material.dart';

import '../widget/textWidget.dart';

class GlobalMethods{
  static navigateTo({required BuildContext ctx,required String routeName})
  {
    Navigator.pushNamed(ctx, routeName);
  }


  static   Future<void> warningDialog({

  required String title,
  required String subTitle,
  required Function fct,
  required BuildContext context,



}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title:  Text(title),
              content:  Text(subTitle),
              actions: [
                TextButton(
                  onPressed: () {
                    if(Navigator.canPop(context))
                      {
                        Navigator.pop(context);
                      }

                  },
                  child: TextWidget(
                    title: "Cancel",
                    color: Colors.cyan,
                    textSize: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    fct();
                    if(Navigator.canPop(context))
                    {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    title: "ok",
                    color: Colors.cyan,
                    textSize: 20,
                  ),
                )
              ]);
        });
  }


  static   Future<void> errorDialog({

    required String subTitle,
    required BuildContext context,



  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title:  const Text('Something Went Wrong'),
              content:  Text(subTitle),
              actions: [
                TextButton(
                  onPressed: () {
                    if(Navigator.canPop(context))
                    {
                      Navigator.pop(context);
                    }

                  },
                  child: TextWidget(
                    title: "ok",
                    color: Colors.cyan,
                    textSize: 20,
                  ),
                ),
              ]);
        });
  }

}