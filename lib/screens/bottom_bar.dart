import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/cataegories.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/userScreen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import 'cartScreen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List <Map<String,dynamic>> _pages = [

    {"page": const HomeScreen(), "title": "Home",},
    { "page":  CategoriesScreen(), "title": "Category",},
    {"page": const CartScreen(), "title": "Cart",},
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
        backgroundColor: themeState.getDarkTheme ? Theme.of(context).cardColor:Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: themeState.getDarkTheme ? Colors.white:Colors.black,
        onTap: _selectedPage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.category), label: "Category"),
          BottomNavigationBarItem(icon: Icon(IconlyLight.buy), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(IconlyLight.user), label: "User"),
        ],
      ),
    );
  }
}
