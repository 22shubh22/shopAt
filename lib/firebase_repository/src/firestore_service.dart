import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopat/firebase_repository/auth.dart';
import 'package:shopat/firebase_repository/src/entities/product_entity.dart';
import 'package:shopat/firebase_repository/src/models/wishlist_item.dart';

class FirestoreService {
  //firestore instance to user multiple times.
  FirebaseFirestore _instance = FirebaseFirestore.instance;

  getUserByPhone(String phoneNumber, String? uid) async {
    var s = await _instance.collection('users').doc(phoneNumber).get();
    if (s.data() == null) {
      print("User with phone number $phoneNumber not exists. Signing him up");
      await _instance.collection('users').doc(phoneNumber).set({
        'phoneNumber': phoneNumber,
        'uid': uid,
        'address': "",
        'name': "",
        'email': "",
        'wishlist': [],
        'orders': [],
        'cart': [],
      });
    } else {
      print(
          "User with phone number $phoneNumber already exists. Just logging in");
    }
  }

  Future<List<ProductEntity>> getProductsList() async {
    List<ProductEntity> productsList = [];
    var products = await _instance.collection('products').get();

    for (var i in products.docs) {
      var data = i.data();
      productsList.add(ProductEntity.fromJson(data));
    }
    return productsList;
  }

  Future<bool> isItemWishListed(String pId) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('users').doc(phoneNumber).get();
    List wishList = data.data()?['wishlist'];
    bool _isProductAdded = false;
    for (var i in wishList) {
      if (i['id'] == pId) {
        _isProductAdded = true;
        break;
      }
    }
    return _isProductAdded;
  }

  addProductToWishList(
    ProductEntity product,
  ) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('users').doc(phoneNumber).get();

    List wishList = data.data()?['wishlist'];

    wishList.add({
      "id": product.id,
      "productName": product.productName,
      "shopId": product.shopId,
      "description1": product.description1,
      "description2": product.description2,
      "image": product.image,
      "costPrice": product.costPrice,
      "sellingPrice": product.sellingPrice,
      "quantityAvailable": product.quantityAvailable,
      "addedOn": DateTime.now().toString()
    });

    try {
      await _instance
          .collection('users')
          .doc(phoneNumber)
          .update({'wishlist': wishList});

      print(" Item added to wishlist");

      BotToast.showText(text: "Item added to your wishlist");
    } catch (e) {
      print("error adding item to wishlist : $e");

      BotToast.showText(text: "Cannot add item to your wishlist right now.");
    }
  }

  removeProductToWishList(
    String productId,
  ) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('users').doc(phoneNumber).get();

    List wishList = data.data()?['wishlist'];
    int? indexToRemove;
    for (var i in wishList) {
      if (i['id'] == productId) {
        indexToRemove = wishList.indexOf(i);
        break;
      }
    }
    if (indexToRemove != null) {
      wishList.removeAt(indexToRemove);
    }

    try {
      await _instance
          .collection('users')
          .doc(phoneNumber)
          .update({'wishlist': wishList});

      print(" Item removed from wishlist");

      BotToast.showText(text: "Item removed from your wishlist");
    } catch (e) {
      print("error removing item from wishlist : $e");

      BotToast.showText(
          text: "Cannot remove item from your wishlist right now.");
    }
  }

  Future<List<WishListItem>> getUserWishList() async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    List<WishListItem> wishList = [];
    var user = await _instance.collection('users').doc(phoneNumber).get();

    for (var i in user.data()?['wishlist']) {
      wishList.add(WishListItem.fromJson(i));
    }
    return wishList;
  }

  getProfileDetails() async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('users').doc(phoneNumber).get();
    String name = data.data()?['name'];
    String email = data.data()?['email'];
    String address = data.data()?['address'];
    return {
      'name': name,
      'email': email,
      'address': address,
    };
  }

  updateProfileDetails({
    required String name,
    required String email,
    required String address,
  }) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    try {
      await _instance.collection('users').doc(phoneNumber).update({
        'name': name,
        'email': email,
        'address': address,
      });
      print("Profile details updated");

      BotToast.showText(text: "Profile details updated");
    } catch (e) {
      print("error while updating profile : $e");

      BotToast.showText(text: "Cannot update your details");
    }
  }
}
