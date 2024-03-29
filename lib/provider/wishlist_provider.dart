import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebase.dart';
import '../models/wishListModel.dart';
import '../services/global_methods.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};
  final userCollection = FirebaseFirestore.instance.collection('users');


  Map<String, WishlistModel> get getWishlistItem {
    return _wishlistItems;
  }
 void addAWishlist ({required String productId, required BuildContext context})async{
   final User? user = auth.currentUser;

   final wishListId = const Uuid().v4();
   try  {
     userCollection.doc(user!.uid).update({
       'userWish': FieldValue.arrayUnion([
         {
           'wishListId': wishListId,
           'productId': productId,

         }
       ])
     });
     Toast.show(
       "Item Has been added to your wishlist",
       duration: Toast.lengthLong,
       gravity: Toast.bottom,
       backgroundColor: Colors.grey.shade600,

     );

   } catch (error) {
     GlobalMethods.errorDialog(subTitle: error.toString(), context: context);
   }
    notifyListeners();
 }
  Future<void> fetchWish() async {
    final User? user = auth.currentUser;


    final DocumentSnapshot userDoc =
    await userCollection.doc(user!.uid).get();

    final leng = userDoc.get('userWish').length;
    for (int i = 0; i < leng; i++) {
      _wishlistItems.putIfAbsent(
          userDoc.get('userWish')[i]['productId'],
              () => WishlistModel(
            id: userDoc.get('userWish')[i]['wishListId'],
            productId: userDoc.get('userWish')[i]['productId'],
          ));
    }
    notifyListeners();
  }


  Future <void> removeItem({required String productId,required String wishListId, })
  async {
    final User? user = auth.currentUser;

    await userCollection.doc(user!.uid).update({'userWish':FieldValue.arrayRemove(
        [ {
          'wishListId':wishListId  ,
          'productId':productId,

        }
        ])});
    _wishlistItems.remove(productId);
   await fetchWish();
    notifyListeners();

  }
  Future <void> clear()
  async {
    final User? user = auth.currentUser;

    if(user != null)
      {
        await userCollection.doc(user.uid).update({
          'userWish':[],
        });
      }

    _wishlistItems.clear();
    notifyListeners();
  }


}