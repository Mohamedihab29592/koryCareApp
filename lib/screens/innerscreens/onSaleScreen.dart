import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/products_model.dart';
import '../../provider/products_provider.dart';
import '../../services/utilies.dart';
import '../../widget/backWidget.dart';
import '../../widget/empty_products_widget.dart';
import '../../widget/onSaleWidget.dart';
import '../../widget/textWidget.dart';


class OnSale extends StatelessWidget {
  const OnSale({Key? key}) : super(key: key);
  static const routeName = "/onSaleScreen";

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = utils.color;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> onSaleProducts = productProviders.getOnSaleProducts;

    Size size = utils.screenSize;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: "Products on Sale",
          color: color,
          textSize: 24,
          isTitle: true,
        ),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        leading: const BackWidget(),
      ),
      body: onSaleProducts.isEmpty
          ?  const EmptyProdWidget(text: "No Products On Sale Yet!!\n Stay tuned ",)
          : GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              crossAxisCount: 1,
              childAspectRatio: size.width / (size.height * 0.17),
              children: List.generate(
                onSaleProducts.length,
                (index) {
                  return ChangeNotifierProvider.value(
                    value: onSaleProducts[index],
                    child: const OnSaleWidget(),
                  );


                }
              ),
            ),
    );
  }
}
