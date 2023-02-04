import 'package:flutter/material.dart';
import 'package:grocery_app/widget/backWidget.dart';
import 'package:grocery_app/widget/textWidget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../models/products_model.dart';
import '../../provider/products_provider.dart';
import '../../services/utilies.dart';
import '../../widget/empty_products_widget.dart';
import '../../widget/feed_item.dart';


class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);
  static const routeName = "/feedsScreen";

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<ProductModel> listProductSearch = [];


  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = utils.color;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;

    Size size = utils.screenSize;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: "All Products",
          color: color,
          textSize: 24,
          isTitle: true,
        ),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        leading: const BackWidget(),
      ),
      body: allProducts.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    IconlyLight.danger,
                    size: 200,
                  ),
                  Text(
                    "No Products Yet!!\n Stay tuned ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: color,
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextFormField(
                        focusNode: _searchFocusNode,
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            listProductSearch = productProviders.searchQuery(value);

                          });
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.blue, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 1),
                            ),
                            hintText: "Whats is in your mind?",
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  _searchFocusNode.unfocus();
                                },
                                icon: Icon(
                                  _searchFocusNode.hasFocus? Icons.close:null,size: 25,
                                  color: Colors.red,
                                ))),
                      ),
                    ),
                  ),
                  _searchController.text.isNotEmpty && listProductSearch.isEmpty? const  EmptyProdWidget(text: 'No Products belong to this category',) :
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: size.width / (size.height * 0.55),
                    children: List.generate(
                        _searchController.text.isNotEmpty ? listProductSearch.length:


                        allProducts.length, (index)  {
                      return ChangeNotifierProvider.value(
                      value: _searchController.text.isNotEmpty ? listProductSearch[index]:

                      allProducts[index],
                      child: const FeedsWidget(),
                    );
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}
