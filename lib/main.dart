import 'package:flutter/material.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/feedsScreen.dart';
import 'package:grocery_app/screens/onSaleScreen.dart';
import 'package:grocery_app/screens/orderScreen/orderScreen.dart';
import 'package:grocery_app/screens/productDetails.dart';
import 'package:grocery_app/screens/viewedOnlyScreen/viewedScreen.dart';
import 'package:grocery_app/screens/wishList/wishlistScreen.dart';
import 'package:provider/provider.dart';

import 'auth/forget_pass.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'consts/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(
              builder: (context, themeProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const LoginScreen(),
        routes:{
          OnSale.routeName:(ctx) => const OnSale(),
          FeedsScreen.routeName:(ctx) => const FeedsScreen(),
          WishListScreen.routeName:(ctx) => const WishListScreen(),
          OrderScreen.routeName:(ctx) => const OrderScreen(),
          ViewedScreen.routeName:(ctx) => const ViewedScreen(),
          ProductDetails.routeName:(ctx) => const ProductDetails(),
          RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
        } );

      }),
    );
  }
}
