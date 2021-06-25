import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopat/firebase_repository/auth.dart';
import 'package:shopat/firebase_repository/src/entities/product_entity.dart';

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

  Future<bool> isItemWishListed(String id) async{
    String phoneNumber = AuthService().getPhoneNumber()??"";
    var data = await _instance.collection('users').doc(phoneNumber).get();
    List wishList = data.data()?['wishlist'];
    for(var i in ){
      
    }
    return true;
  }
}
