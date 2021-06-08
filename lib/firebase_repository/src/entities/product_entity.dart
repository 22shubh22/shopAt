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
}
