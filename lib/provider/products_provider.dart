import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/products_model.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> get getProducts {
    return _productsList;
  }



  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  ProductModel findById(String id)
  {
    return _productsList.firstWhere((element) => element.id == id);
  }

  List<ProductModel> findByCategory(String categoryName){
    List<ProductModel> categoryList = _productsList.where((element) => element.productCategoryName.toLowerCase().contains(categoryName.toLowerCase())).toList();
    return categoryList;
  }

  static final List<ProductModel> _productsList = [];

  Future<void> fetchProducts() async {

    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
          _productsList.clear();
      for (var element in productSnapshot.docs) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('productCategoryName'),
              price: double.parse(
                element.get('price'),
              ),
              salePrice: element.get('sale_price'),
              isOnSale: element.get('isOnSale'),
              items:element.get('items')
            ));
      }
    });
    notifyListeners();
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> searchList = _productsList
        .where(
          (element) => element.title.toLowerCase().contains(
        searchText.toLowerCase(),
      ),
    )
        .toList();
    return searchList;
  }

}

/* static final List<ProductModel> productsList = [
    ProductModel(
      id: '1',
      title: 'Cream Foot Care',
      price: 3.87,
      salePrice: 2.98,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/H14f02112548344cd9a08b6b7d97a58ado.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: true,
    ),
    ProductModel(
      id: '2',
      title: 'Mask Care',
      price: 0.5,
      salePrice: 0.0,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/H92141926137d46d5b3adf6e77e107adew.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: false,
    ),
    ProductModel(
      id: '3',
      title: 'Hyaluronic acid',
      price: 33,
      salePrice: 20,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/Hb242030381f241afa7a1b1b82674eb62h.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: true,
    ),
    ProductModel(
      id: '4',
      title: 'Soft plump',
      price: 30,
      salePrice: 25,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/Sb27dce2c6f574f4b9b109f25f79f0976t.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: true,
    ),
    ProductModel(
      id: '5',
      title: 'Sun Block Cream  ',
      price: 36,
      salePrice: 0.0,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/H43b3e75113cd46e587b682a9555f6d87h.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: false,
    ),
    ProductModel(
      id: '6',
      title: 'Face Mask',
      price: 0.21,
      salePrice: 0.10,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/H3c1901e1542e4d0b865711c048ab53d4n.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: true,
    ),
    // Vegi
    ProductModel(
      id: '7',
      title: 'Face Mask',
      price: 3,
      salePrice: 0.0,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/H1bc23cb42f31455eb5ca3a75aa94fa01I.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: false,
    ),
    ProductModel(
      id: '8',
      title: 'Soft Scrab',
      price: 1.76,
      salePrice: 0.0,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/Acd9183b5e9e64fd8a9c6eec08effee8bh.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: false,
    ),
    ProductModel(
      id: '9',
      title: 'oraganic Skin Care',
      price: 1.81,
      salePrice: 0.0,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/H2149242913314ae0abdbc44a59e11457X.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: false,
    ),
    ProductModel(
      id: '10',
      title: 'Collagen Face Cream',
      price: 50,
      salePrice: 0,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/H60c47939e75b476f844729eeb6b51b08k.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: false,
    ),
    ProductModel(
      id: '11',
      title: 'Vitamin C Skin Care',
      price: 2.50,
      salePrice: 0.0,
      imageUrl: 'https://s.alicdn.com/@sc04/kf/H361181e2592a401793475888ddee5e42A.jpg_300x300.jpg',
      productCategoryName: 'skin care',
      isOnSale: false,
    ),
    *//* ProductModel(
      id: 'Plantain-flower',
      title: 'Plantain-flower',
      price: 0.99,
      salePrice: 0.389,
      imageUrl: 'https://i.ibb.co/RBdq0PD/Plantain-flower.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Potato',
      title: 'Potato',
      price: 0.99,
      salePrice: 0.59,
      imageUrl: 'https://i.ibb.co/wRgtW55/Potato.png',
      productCategoryName: 'Vegetables',
      isOnSale: true,
      isPiece: false,
    ),
    ProductModel(
      id: 'Radish',
      title: 'Radish',
      price: 0.99,
      salePrice: 0.79,
      imageUrl: 'https://i.ibb.co/YcN4ZsD/Radish.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Red peppers',
      title: 'Red peppers',
      price: 0.99,
      salePrice: 0.57,
      imageUrl: 'https://i.ibb.co/JthGdkh/Red-peppers.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Squash',
      title: 'Squash',
      price: 3.99,
      salePrice: 2.99,
      imageUrl: 'https://i.ibb.co/p1V8sq9/Squash.png',
      productCategoryName: 'Vegetables',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Tomatoes',
      title: 'Tomatoes',
      price: 0.99,
      salePrice: 0.39,
      imageUrl: 'https://i.ibb.co/PcP9xfK/Tomatoes.png',
      productCategoryName: 'Vegetables',
      isOnSale: true,
      isPiece: false,
    ),
    // Grains
    ProductModel(
      id: 'Corn-cobs',
      title: 'Corn-cobs',
      price: 0.29,
      salePrice: 0.19,
      imageUrl: 'https://i.ibb.co/8PhwVYZ/corn-cobs.png',
      productCategoryName: 'Grains',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Peas',
      title: 'Peas',
      price: 0.99,
      salePrice: 0.49,
      imageUrl: 'https://i.ibb.co/7GHM7Dp/peas.png',
      productCategoryName: 'Grains',
      isOnSale: false,
      isPiece: false,
    ),
    // Herbs
    ProductModel(
      id: 'Asparagus',
      title: 'Asparagus',
      price: 6.99,
      salePrice: 4.99,
      imageUrl: 'https://i.ibb.co/RYRvx3W/Asparagus.png',
      productCategoryName: 'Herbs',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Brokoli',
      title: 'Brokoli',
      price: 0.99,
      salePrice: 0.89,
      imageUrl: 'https://i.ibb.co/KXTtrYB/Brokoli.png',
      productCategoryName: 'Herbs',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Buk-choy',
      title: 'Buk-choy',
      price: 1.99,
      salePrice: 0.99,
      imageUrl: 'https://i.ibb.co/MNDxNnm/Buk-choy.png',
      productCategoryName: 'Herbs',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Chinese-cabbage-wombok',
      title: 'Chinese-cabbage-wombok',
      price: 0.99,
      salePrice: 0.5,
      imageUrl: 'https://i.ibb.co/7yzjHVy/Chinese-cabbage-wombok.png',
      productCategoryName: 'Herbs',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Kangkong',
      title: 'Kangkong',
      price: 0.99,
      salePrice: 0.5,
      imageUrl: 'https://i.ibb.co/HDSrR2Y/Kangkong.png',
      productCategoryName: 'Herbs',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Leek',
      title: 'Leek',
      price: 0.99,
      salePrice: 0.5,
      imageUrl: 'https://i.ibb.co/Pwhqkh6/Leek.png',
      productCategoryName: 'Herbs',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Spinach',
      title: 'Spinach',
      price: 0.89,
      salePrice: 0.59,
      imageUrl: 'https://i.ibb.co/bbjvgcD/Spinach.png',
      productCategoryName: 'Herbs',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Almond',
      title: 'Almond',
      price: 8.99,
      salePrice: 6.5,
      imageUrl: 'https://i.ibb.co/c8QtSr2/almand.jpg',
      productCategoryName: 'Nuts',
      isOnSale: true,
      isPiece: false,
    ),*//*
  ];*/

