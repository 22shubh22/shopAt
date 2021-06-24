import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopat/firebase_repository/firebase_repository.dart';
import 'entities/entities.dart';

class FirebaseProductRepository implements ProductsRepository {
  final productsCollection = FirebaseFirestore.instance.collection('products');

  @override
  Future<void> addNewProduct(ProductInfo data) {
    return productsCollection.add(data.toEntity().toDocument());
  }

  @override
  Stream<List<ProductInfo>> approvedProducts() {
    print('TODO: this needs to be done');
    return productsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductInfo.fromEntity(ProductEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}

class FirebaseCustomersRepository implements CustomersRepository {
  final customersCollection =
      FirebaseFirestore.instance.collection('customers');

  @override
  Future<void> addNewCustomer(CustomerInfo data) {
    return customersCollection.add(data.toEntity().toDocument());
  }
}
