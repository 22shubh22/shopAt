import 'package:cloud_firestore/cloud_firestore.dart';

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
        'name': "Dundi Raja Vamsi Reddy Garuu",
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
}
