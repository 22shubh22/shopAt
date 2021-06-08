import 'dart:ui';

import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class ProductInfo {
  final String id;
  final String productName;
  final String shopId;
  final String description1;
  final String description2;
  final String image;
  final int costPrice;
  final int sellingPrice;
  final int quantityAvailable;

  ProductInfo(
      {required String id,
      required this.productName,
      required this.shopId,
      required this.description1,
      required this.description2,
      required this.image,
      required this.costPrice,
      required this.sellingPrice,
      required this.quantityAvailable})
      : this.id = id;

  /*ProductInfo copyWith({
    String id,
    String productName,
    String shopId,
    String description1,
    String? description2,
    String image,
    int costPrice,
    int sellingPrice,
    int quantityAvailable
  }) {
    return ProductInfo(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        shopId: shopId ?? this.shopId,
        description1: description1 ?? this.description1,
        description2: description2 ?? this.description2,
        image: image ?? this.image,
        costPrice: costPrice ?? this.costPrice,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        quantityAvailable: quantityAvailable ?? this.quantityAvailable,
  }*/

  @override
  String toString() {
    return "Order($id, $productName)";
  }

  ProductEntity toEntity() {
    return ProductEntity(id, productName, shopId, description1, description2,
        image, costPrice, sellingPrice, quantityAvailable);
  }

  static ProductInfo fromEntity(ProductEntity entity) {
    return ProductInfo(
      id: entity.id,
      productName: entity.productName,
      shopId: entity.shopId,
      description1: entity.description1,
      description2: entity.description2,
      image: entity.image,
      costPrice: entity.costPrice,
      sellingPrice: entity.sellingPrice,
      quantityAvailable: entity.quantityAvailable,
    );
  }
}
