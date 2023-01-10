import 'package:flutter/material.dart';
import 'package:grocery_app/screens/orderScreen/orderScreen.dart';
import 'package:grocery_app/screens/viewedOnlyScreen/viewedScreen.dart';
import 'package:grocery_app/screens/wishList/wishlistScreen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../widget/textWidget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                        text: "MyName",
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
              TextWidget(title: "bebo@gmail.com", color: color, textSize: 18),
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
                  subtitle: "MyAddress2",
                  icon: IconlyLight.profile,
                  onPressed: () async {
                    await _showAddressDialog();
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
                    GlobalMethods.navigateTo(ctx: context, routeName: ViewedScreen.routeName);

                  },
                  color: color),
              _listTitle(
                  title: "Forget password",
                  icon: IconlyLight.unlock,
                  onPressed: () {},
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
                  title: "Logout",
                  icon: IconlyLight.login,
                  onPressed: () async {
                    await GlobalMethods.warningDialog(title: 'SignOut', subTitle: "Do you Want to SignOut?", fct: (){}, context: context);
                  },
                  color: color),
            ],
          ),
        ),
      ),
    ));
  }


  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Update'),
              content: TextField(
                // onChanged: (value){
                //   print("hi");
                // },
                controller: _textEditingController,
                maxLines: 5,
                decoration: const InputDecoration(hintText: "Your Address"),
              ),
              actions: [
                TextButton(
                  onPressed: () {},
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
