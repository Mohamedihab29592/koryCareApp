import 'package:KoryCare/screens/userScreen.dart';
import 'package:flutter/material.dart';


import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/dark_theme_provider.dart';
import '../provider/products_provider.dart';
import '../widget/textWidget.dart';
import 'cart/cart.dart';
import 'cataegories.dart';
import 'home_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {


  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {
      "page": const HomeScreen(),
      "title": "Home",
    },
    {
      "page": CategoriesScreen(),
      "title": "Category",
    },
    {
      "page": const CartScreen(),
      "title": "Cart",
    },
    {
      "page": const UserScreen(),
      "title": "User",
    }
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      /*appBar: AppBar(title: Text(_pages[_selectedIndex]['title']),
      backgroundColor: themeState.getDarkTheme ? Colors.black:Colors.white,),*/
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeState.getDarkTheme
            ? Theme.of(context).cardColor
            : Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor:
            themeState.getDarkTheme ? Colors.white : Colors.black,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(IconlyLight.category), label: "Category"),
          BottomNavigationBarItem(
              icon: Consumer<CartProvider>(
                builder: (_,myCart,ch) {
                  return Badge(
             label: TextWidget(
                  title: myCart.getCartItems.length.toString(), color: Colors.white, textSize: 10),
    child: const Icon(IconlyLight.buy),
                  );
                }
              ),
              label: "Cart"),
          const BottomNavigationBarItem(icon: Icon(IconlyLight.user), label: "User"),
        ],
      ),
    );
  }
}
