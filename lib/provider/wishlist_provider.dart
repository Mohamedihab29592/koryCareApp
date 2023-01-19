import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/wishListModel.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItem {
    return _wishlistItems;
  }
 void addAndRemoveWishlist ({required String productId}){
    if (_wishlistItems.containsKey(productId))
      {
        removeItem(productId);
      }else
        {
          _wishlistItems.putIfAbsent(productId, () => WishlistModel(productId: productId, id: DateTime.now().toString()));
        }
    notifyListeners();
 }

  void removeItem(String productId)
  {
    _wishlistItems.remove(productId);
    notifyListeners();

  }
  void clear()
  {
    _wishlistItems.clear();
    notifyListeners();
  }
}