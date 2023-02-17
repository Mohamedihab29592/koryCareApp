import 'package:flutter/material.dart';

import '../services/utilies.dart';

class EmptyProdWidget extends StatelessWidget {
  const EmptyProdWidget({Key? key,required this.text}) : super(key: key);
final String text;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(

                  'assets/analysis.png',
                  height: 250,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 100,),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: color, fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
