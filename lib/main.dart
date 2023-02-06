import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/provider/orderProvider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/provider/viewed_prod_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/screens/bottom_bar.dart';
import 'package:grocery_app/screens/innerscreens/CateogryScreen.dart';
import 'package:grocery_app/screens/innerscreens/feedsScreen.dart';
import 'package:grocery_app/screens/innerscreens/onSaleScreen.dart';
import 'package:grocery_app/screens/innerscreens/productDetails.dart';
import 'package:grocery_app/screens/orderScreen/orderScreen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently.dart';
import 'package:grocery_app/screens/wishList/wishlistScreen.dart';
import 'package:provider/provider.dart';

import 'auth/forget_pass.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'consts/theme_data.dart';
import 'fetch_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
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
  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,

      builder: (context,snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                )),
          );
        } else if (snapshot.hasError) {
          const MaterialApp(
            home: Scaffold(
                body: Center(
                  child: Text('An error Occurred'),
                )),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ProductsProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => WishlistProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => ViewedProdProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => OrderProvider(),
            ),
            ChangeNotifierProvider(create: (_) {
              return themeChangeProvider;
            }),
            ChangeNotifierProvider(create: (_) {
            }),
          ],
          child:
              Consumer<DarkThemeProvider>(
                  builder: (context, themeProvider, child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Kory Care',
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                home: const FetchScreen(),
            routes:{
              OnSale.routeName:(ctx) => const OnSale(),
              FeedsScreen.routeName:(ctx) => const FeedsScreen(),
              WishListScreen.routeName:(ctx) => const WishListScreen(),
              OrderScreen.routeName:(ctx) => const OrderScreen(),
              ViewedRecentlyScreen.routeName:(ctx) => const ViewedRecentlyScreen(),
              ProductDetails.routeName:(ctx) => const ProductDetails(),
              RegisterScreen.routeName: (ctx) => const RegisterScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
              CategoryScreen.routeName: (ctx) => const CategoryScreen(),
            } );

          }),
        );
      }
    );
  }
}
