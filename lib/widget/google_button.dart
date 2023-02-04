import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/screens/bottom_bar.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widget/textWidget.dart';

import '../consts/firebase.dart';
import '../fetch_screen.dart';

class GoogleButton extends StatelessWidget {
   GoogleButton({Key? key}) : super(key: key);
Future<void> _googleSignIn(context)async {
  final googleSignIn = GoogleSignIn();
  final googleAccount = await googleSignIn.signIn();
  if (googleAccount != null) {
   final googleAuth = await googleAccount.authentication;
   if(googleAuth.accessToken != null && googleAuth.idToken !=null)
     {
       try{
         await auth.signInWithCredential(GoogleAuthProvider.credential(idToken: googleAuth.idToken,
         accessToken: googleAuth.accessToken));
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const FetchScreen(),));

       }on FirebaseException catch(error)
       {;
         GlobalMethods.errorDialog(subTitle: "${error.message}", context: context);

       }catch (error)
       {
         GlobalMethods.errorDialog(subTitle: "$error", context: context);


       }
       finally{

       }
     }
  }
}
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/google.png',
              width: 40.0,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          TextWidget(
              title: 'Sign in with google', color: Colors.white, textSize: 18)
        ]),
      ),
    );
  }
}
