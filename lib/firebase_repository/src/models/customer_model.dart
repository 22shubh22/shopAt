import 'dart:ui';

import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class CustomerInfo {
  final String number;
  final String defaultAddress;
  final List orders;
  final List wishlist;

  CustomerInfo(
      {required this.number,
      required this.defaultAddress,
      required this.orders,
      required this.wishlist});

  CustomerEntity toEntity() {
    return CustomerEntity(
      number,
      defaultAddress,
      orders,
      wishlist,
    );
  }

  static CustomerInfo fromEntity(CustomerEntity entity) {
    return CustomerInfo(
      number: entity.number,
      defaultAddress: entity.defaultAddress,
      orders: entity.orders,
      wishlist: entity.wishlist,
    );
  }
}
