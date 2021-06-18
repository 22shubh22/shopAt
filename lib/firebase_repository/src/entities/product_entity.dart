import 'dart:io';
// TODO: integrate firebase and cloud_firestore with the app
import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: isApproved field in product wntity and model
class ProductEntity {
  final String id;
  final String productName;
  final String shopId;
  final String description1;
  final String description2;
  final String image;
  final int costPrice;
  final int sellingPrice;
  final int quantityAvailable;

  ProductEntity(
      this.id,
      this.productName,
      this.shopId,
      this.description1,
      this.description2,
      this.image,
      this.costPrice,
      this.sellingPrice,
      this.quantityAvailable);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "productName": productName,
      "shopId": shopId,
      "description1": description1,
      "description2": description2,
      "image": image,
      "costPrice": costPrice,
      "sellingPrice": sellingPrice,
      "quantityAvailable": quantityAvailable
    };
  }

  static ProductEntity fromJson(Map<String, Object> json) {
    return ProductEntity(
      json["id"] as String,
      json["productName"] as String,
      json["shopId"] as String,
      json["description1"] as String,
      json["description2"] as String,
      json["image"] as String,
      json["costPrice"] as int,
      json["sellingPrice"] as int,
      json["quantityAvailable"] as int,
    );
  }

  static ProductEntity fromSnapshot(DocumentSnapshot snap) {
    print((snap.data() as dynamic)['quantityAvailable']);
    return ProductEntity(
        snap.id,
        (snap.data() as dynamic)['productName'],
        (snap.data() as dynamic)['shopId'],
        (snap.data() as dynamic)['description1'],
        (snap.data() as dynamic)['description2'],
        (snap.data() as dynamic)['image'],
        (snap.data() as dynamic)['costPrice'],
        (snap.data() as dynamic)['sellingPrice'],
        (snap.data() as dynamic)['quantityAvailable']);
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "productName": productName,
      "shopId": shopId,
      "description1": description1,
      "description2": description2,
      "image": image,
      "costPrice": costPrice,
      "sellingPrice": sellingPrice,
      "quantityAvailable": quantityAvailable
    };
  }
}
