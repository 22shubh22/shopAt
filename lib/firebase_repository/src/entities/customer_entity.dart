// import 'dart:ffi';
// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerEntity {
  final String number;
  final String defaultAddress;
  final List orders;
  final List wishlist;

  CustomerEntity(
    this.number,
    this.defaultAddress,
    this.orders,
    this.wishlist,
  );

  Map<String, Object> toJson() {
    return {
      "number": number,
      "defaultAddress": defaultAddress,
      "orders": orders,
      "wishlist": wishlist,
    };
  }

  static CustomerEntity fromJson(Map<String, Object> json) {
    return CustomerEntity(
      json["number"] as String,
      json["defaultAddress"] as String,
      json["orders"] as List,
      json["wishlist"] as List,
    );
  }

  static CustomerEntity fromSnapshot(DocumentSnapshot snap) {
    return CustomerEntity(
      (snap.data() as dynamic)['number'],
      (snap.data() as dynamic)['defaultAddress'],
      (snap.data() as dynamic)['orders'],
      (snap.data() as dynamic)['wishlist'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "number": number,
      "defaultAddress": defaultAddress,
      "orders": orders,
      "wishlist": wishlist,
    };
  }
}
