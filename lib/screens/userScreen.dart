import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/auth/login.dart';
import 'package:grocery_app/consts/firebase.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently.dart';
import 'package:grocery_app/screens/wishList/wishlistScreen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../auth/forget_pass.dart';
import '../provider/cart_provider.dart';
import '../provider/dark_theme_provider.dart';
import '../provider/orderProvider.dart';
import '../provider/products_provider.dart';
import '../provider/wishlist_provider.dart';
import '../widget/loading_manager.dart';
import '../widget/textWidget.dart';
import 'orderScreen/orderScreen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();




  bool _isLoading = false;
  String ? _email ;
  String ? _name ;
  String ? _address ;
  String ?_phone;
  final User? user = auth.currentUser;


  @override
  void initState() {
 getUserData() ;
    super.initState();
  }

  Future<void> getUserData ()async{
    _isLoading = true;
    if(user == null )
    {
      _isLoading = false;

      return;
    }
    try {
      String uid = user!.uid;
      final DocumentSnapshot userData = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      _email =userData.get('email');
      _name =userData.get('name');
      _address =userData.get('shipping_address');
      _phone = userData.get('phone');
      _textEditingController.text = userData.get("shipping_address");
    }catch (error){
      _isLoading = false;

      GlobalMethods.errorDialog(subTitle: "$error", context: context);
    }finally{
      setState(() {
        _isLoading = false;
      });

    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final productsProvider =
    Provider.of<ProductsProvider>(context, listen: false);
    final cartProvider =
    Provider.of<CartProvider>(context, listen: false);
    final wishProvider =
    Provider.of<WishlistProvider>(context, listen: false);
    final orderProvider =
    Provider.of<OrderProvider>(context, listen: false);

    return Scaffold(
        body: LoadingManager(
          isLoading: _isLoading,
          child: Center(
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "HI, ",
                        style: const TextStyle(
                            color: Colors.cyan,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text:_name==null?'user':_name!,
                            style: TextStyle(
                                fontSize: 25,
                                color: color,
                                fontWeight: FontWeight.w600),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(title: _email==null?'user':_email! , color: color, textSize: 18),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTitle(
                      title: "Address",
                      subtitle: _address==null?'address':_address!,
                      icon: IconlyLight.profile,
                      onPressed: () async {
                        String uid = user!.uid;
                        await _showAddressDialog(
                          max: 3,
                            vaild: FilteringTextInputFormatter.allow(
                              RegExp('[0-9-a-z-A-Z- ]'),
                            ),


                            textEditingController: _textEditingController,title: 'Your Address', fun:(){
                           FirebaseFirestore.instance.collection("users").doc(uid).update({'shipping_address':_textEditingController.text,});
                           _textEditingController.clear();

                        }  );
                      },
                      color: color),
                  _listTitle(
                      title: "phone",
                      subtitle: _phone==null?'':_phone!,
                      icon: IconlyLight.call,
                      onPressed: () async {
                        String uid = user!.uid;

                        await _showAddressDialog(
                          max: 1,
                          vaild: FilteringTextInputFormatter.allow(
                            RegExp('[0-9]'),
                          ),


                            textEditingController: _phoneEditingController,title: 'Your Phone', fun: (){
                          if (_phoneEditingController.text.length ==11  ) {
                            FirebaseFirestore.instance.collection("users").doc(uid).update({'phone':_phoneEditingController.text,});

                          } else {
                             Fluttertoast.showToast(
                              msg: "Enter A valid Mobile number ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                               backgroundColor: Colors.red,
                               fontSize: 20
                            );
                             _phoneEditingController.clear();


                          }

                        });
                      },
                      color: color),
                  _listTitle(
                      title: "Orders",
                      icon: IconlyLight.bag,
                      onPressed: () {
                        GlobalMethods.navigateTo(ctx: context, routeName: OrderScreen.routeName);
                      },
                      color: color),
                  _listTitle(
                      title: "Wishlist",
                      icon: IconlyLight.heart,
                      onPressed: () {
                        GlobalMethods.navigateTo(ctx: context, routeName: WishListScreen.routeName);
                      },
                      color: color),
                  _listTitle(
                      title: "Viewed",
                      icon: IconlyLight.show,
                      onPressed: () {
                        GlobalMethods.navigateTo(ctx: context, routeName: ViewedRecentlyScreen.routeName);

                      },
                      color: color),
                  _listTitle(
                      title: "Forget password",
                      icon: IconlyLight.unlock,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ForgetPasswordScreen()));

                      },
                      color: color),
                  SwitchListTile(
                    title: TextWidget(
                        title: themeState.getDarkTheme ? "Dark Mode" : "Light Mode",
                        color: color,
                        textSize: 20),
                    secondary: Icon(themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
                    onChanged: (bool value) {
                      setState(() {
                        themeState.setDarkTheme = value;
                      });
                    },
                    value: themeState.getDarkTheme,
                  ),
                  _listTitle(
                      title: user == null ? 'Login': "Logout",
                      icon:user == null ? IconlyLight.login: IconlyLight.logout,
                      onPressed: () async {
                        if(user == null)
                          {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginScreen()
                            )
                            );
                            return ;
                          }
                        await GlobalMethods.warningDialog(title: 'SignOut', subTitle: "Do you Want to SignOut?", fct: ()async{
                          await productsProvider.fetchProducts();
                          await cartProvider.clear();
                          await   wishProvider.clear();
                          await orderProvider.clear();
                         await auth.signOut();

                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginScreen()));

                        }, context: context);
                      },
                      color: color),
                ],
              ),
            ),
          ),
      ),
    ),
        ));
  }


  Future<void> _showAddressDialog({required int max, required String  title,required Function fun,required TextEditingController textEditingController,required FilteringTextInputFormatter vaild}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Update'),
              content: TextField(
                inputFormatters: [
                  vaild,
                ],
                controller: textEditingController,
                maxLines: max,
                decoration:  InputDecoration(hintText: title),
              ),
              actions: [
                TextButton(
                  onPressed: () async{



                    try {
                      fun();
                     await getUserData() ;
                      Navigator.pop(context);


                    } catch(error)
                    {
                      GlobalMethods.errorDialog(subTitle: error.toString(), context: context);
                    }

                  },
                  child: const Text("Update"),
                )
              ]);
        });
  }

  Widget _listTitle(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed,
      required Color color}) {
    return ListTile(
      title: TextWidget(
        title: title,
        color: color,
        textSize: 20,
      ),
      subtitle: TextWidget(
        title: subtitle ?? "",
        color: color,
        textSize: 14,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrow_right_2),
      onTap: () {
        onPressed();
      },
    );
  }


}

