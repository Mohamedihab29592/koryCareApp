import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/consts/firebase.dart';
import 'package:grocery_app/services/global_methods.dart';


import '../../consts/contss.dart';
import '../services/utilies.dart';
import '../widget/auth_button.dart';
import '../widget/backWidget.dart';
import '../widget/loading_manager.dart';
import '../widget/textWidget.dart';


class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();
   bool _isLoading = false;
  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  void _forgetPassFCT() async {
    if(_emailTextController.text.isEmpty || !_emailTextController.text.contains("@"))
      {
        GlobalMethods.errorDialog(subTitle: "Please Enter Vaild Email", context: context);
      }else {
      setState(() {
        _isLoading= true;
      });
      try {
        await auth.sendPasswordResetEmail(email: _emailTextController.text.toLowerCase());
         Fluttertoast.showToast(
             msg: "Check your Email for Reset Link",
             toastLength: Toast.LENGTH_LONG,
             gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.grey.shade600,
             textColor: Colors.white,
             fontSize: 16.0
         );

      }on FirebaseException catch (error)
    {
      GlobalMethods.errorDialog(subTitle: "${error.message}", context: context);
    }


      catch(error)
    {
      GlobalMethods.errorDialog(subTitle: "$error", context: context);
      setState(() {
        _isLoading = false;
      });


    }finally{
        setState(() {
          _isLoading= false;
        });

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Constss.authImagesPaths.length,

              // control: const SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const BackWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    title: 'Forget password',
                    color: Colors.white,
                    textSize: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  TextField(
                    controller: _emailTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Email address',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    buttonText: 'Reset now',
                    fct: () {
                      _forgetPassFCT();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
